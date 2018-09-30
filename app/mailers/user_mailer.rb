class UserMailer < ApplicationMailer
  def daily_summary(user_id)
    @user = User.find(user_id)
    mail(
      to: @user.email,
      subject: 'Daily summary'
    )
  end
end
