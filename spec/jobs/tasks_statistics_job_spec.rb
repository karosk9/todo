require 'rails_helper'

describe TasksStatisticsJob, type: :job do
  include ActiveJob::TestHelper
  let!(:user) { create(:user) }

  subject { described_class }

  it 'enqueues the job' do
    ActiveJob::Base.queue_adapter = :test
    expect { subject.perform_later }.to have_enqueued_job(described_class)
  end

  context 'executes job' do
    it 'sends daily summary' do
      expect(UserMailer).to receive(:daily_summary).with(user.id).and_call_original
      subject.perform_now
    end
  end

  after(:each) do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
