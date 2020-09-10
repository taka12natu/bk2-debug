class RoomsController < ApplicationController
	def create
		@room = Room.create
		@JoinCurrentUser = UserRoom.create(:room_id => @room.id, :user_id => current_user.id)
		@JoinUser = UserRoom.create(join_user_params)
		redirect_to room_path(@room.id)
	end

	def show
		@room = Room.find(params[:id])
		if UserRoom.where(:user_id => current_user.id, :room_id => @room.id).present?
			@chats = @room.chats.includes(:user)
			@chat = Chat.new
			@user_rooms = @room.user_rooms
		else
			redirect_back(fallback_location: root_path)
		end
	end

	private
		def join_user_params
		params.require(:user_room).permit(:user_id, :room_id).merge(room_id: @room.id)
	end
end
