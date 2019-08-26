class AdminMailer < ApplicationMailer
  def registration_confirmation(user)
    @user=user
    mail to: "jmscb56@gmail.com", subject: "Please Confirm your Email Id!"
  end

  def send_mail(name)
    #binding.pry
    user=User.where("name LIKE ?", "%#{name}%")
    unless user.nil?
      mail to: user.first.email, subject: "Mentioned notifications"
    end
  end

end
