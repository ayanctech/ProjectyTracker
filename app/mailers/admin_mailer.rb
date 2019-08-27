class AdminMailer < ApplicationMailer
  def registration_confirmation(user)
    @user=user
    mail to: @user.email, subject: "Please Confirm your Email Id!"
    # send mail to user
  end

  def send_mail(name)
    #binding.pry
    user=User.where("name LIKE ?", "%#{name}%")
    unless user.nil?
      mail to: user.first.email, subject: "Mentioned notifications"
    end
  end

end
