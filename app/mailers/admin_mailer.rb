class AdminMailer < ApplicationMailer
  def registration_confirmation(user)
    @user=user
    mail to: "jmscb56@gmail.com", subject: "Please Confirm your Email Id!"
  end

end
