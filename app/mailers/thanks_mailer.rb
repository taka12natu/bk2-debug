class ThanksMailer < ApplicationMailer
	default from: 'notification@example.com'

	def thanks_email(user)
		@user = user
		mail(to: @user.email, subject: 'Thank you for registering')
	end
end
