class SearchController < ApplicationController

	def search
		@word = params[:word]
		@range = params[:range]
		match = params[:match]

		if @range == "book_range"
			@book = Book.search(@word,match)
		elsif
			@user = User.search(@word,match)
		end
	end

end
