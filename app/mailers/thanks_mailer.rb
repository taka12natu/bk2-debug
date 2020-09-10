class ThanksMailer < ApplicationMailer
	default from: 'notification@example.com'

	def thanks_email(user)
		@user = user
		@url = "http://localhost:3000/users/#{@user.id}"
		mail(to: @user.email, subject: 'Thank you for registering')
	end
end
