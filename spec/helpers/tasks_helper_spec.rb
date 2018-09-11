require 'rails_helper'
require 'spec_helper'

describe 'TasksHelper', type: :helper do
  let(:user) { create(:user) }

  describe '#done' do
    context 'task is completed' do
      let(:task) { create(:task, user: user, completed: true) }
      let(:restore_link) { link_to 'Restore', undone_task_path(task), class: 'btn btn-success restore' }
      it { expect(helper.done(task)).to eql(restore_link) }
    end

    context 'task is not completed' do
      let(:task) { create(:task, user: user, completed: false) }
      let(:done_link) { link_to 'Done!', done_task_path(task), class: 'btn btn-danger done' }
      it { expect(helper.done(task)).to eql(done_link) }
    end
  end

  describe '#created' do
    let(:task) { create(:task, user: user) }
    let(:time_ago) { (time_ago_in_words(task.created_at) + ' ago') }
    it { expect(helper.created(task)).to eql(time_ago) }
  end

  describe '#deadline_time' do
    context 'deadline is today' do
      let(:task) { create(:task, user: user, deadline: Date.today) }
      it { expect(helper.deadline_time(task)).to eql('today') }
    end

    context 'no deadline' do
      let(:task) { create(:task, user: user) }
      it { expect(helper.deadline_time(task)).to eql('no deadline') }
    end

    context 'task is already done' do
      let(:task) { create(:task, user: user, completed: true) }
      it { expect(helper.deadline_time(task)).to eql('done') }
    end

    context 'other' do
      let(:task) { create(:task, user: user, deadline: Date.yesterday) }
      it { expect(helper.deadline_time(task)).to eql('in ' + distance_of_time_in_words(Date.today, task.deadline)) }
    end
  end
end
