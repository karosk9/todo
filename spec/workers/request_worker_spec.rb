require 'rails_helper'

describe RequestWorker, type: :worker do
  describe '#perform' do
    let(:user_email) { 'user@example.com' }
    let(:task_id) { 1 }
    let!(:url) { "http://localhost:3333/api/v1/statistic/respond?user_email=#{user_email}&task_id=#{task_id}" }

    subject { described_class.perform_async(user_email, task_id) }

    it 'enqueues RequestWorker' do
      Sidekiq::Testing.fake! do
        expect { subject }.to change { RequestWorker.jobs.size }.by(1)
      end
    end

    it 'sends request' do
      Sidekiq::Testing.inline! do
        response = instance_double(Excon::Response)
        connection = double(Excon::Connection)
        expect(Excon).to receive(:new).with(url).and_return(connection)
        expect(connection).to receive(:request).with(expects: 200, method: :get, read_timeout: 30 ).and_return(response)

        subject
      end
    end
  end

  after(:each) do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
