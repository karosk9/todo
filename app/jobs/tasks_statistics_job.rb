class TasksStatisticsJob < ApplicationJob
  def perform
    User.pluck(:id).each do |user_id|
      UserMailer.daily_summary(user_id).deliver_now
    end
  end
end
