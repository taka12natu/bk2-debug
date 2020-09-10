class ChatsController < ApplicationController

	def create
		if UserRoom.where(:user_id => current_user.id, :room_id => params[:chat][:room_id]).present?
			@chat = Chat.create(params.require(:chat).permit(:user_id, :chat_messege, :room_id).merge(:user_id => current_user.id))
			redirect_to request.referer
		else
			redirect_back(fallback_location: root_path)
		end
	end
end
