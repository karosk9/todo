class RequestWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 5, :backtrace => true

  def perform(user_email, task_id)
    connection = Excon.new("http://localhost:3333/api/v1/statistic/respond?user_email=#{user_email}&task_id=#{task_id}")
    connection.request(expects: 200, method: :get, read_timeout: 30)
  end
end
