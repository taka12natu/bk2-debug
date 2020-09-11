class Batch::SendMail

	def self.send_mail
		users = User.all
		users.each do |user|
        	DailyMailer.daily_email(user).deliver_now
    	end
     end
end
