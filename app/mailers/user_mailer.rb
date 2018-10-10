class UserMailer < ApplicationMailer
  include UserHelper
  def daily_summary(user_id)
    @user = User.find(user_id)
    @user_tasks = @user.tasks
    @tasks_done = @user_tasks.done_yesterday
    mail(
      to: @user.email,
      subject: 'Daily summary'
    )
  end
end
