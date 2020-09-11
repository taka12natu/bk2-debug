class DailyMailer < ApplicationMailer
	default from: 'notification@example.com'

	def daily_email(user)
		@user = user
		mail(to: @user.email, subject: "Dairy report: #{Date.today}")
	end
end
