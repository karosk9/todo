require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  subject { user }

  describe 'associations' do
    it { is_expected.to have_many(:tasks) }
    it { is_expected.to have_many(:assigned_tasks) }
  end

  describe '#total_todo' do
    let(:other_user) { create(:user) }
    let!(:task) { create(:task, user: other_user, assignee: user)}

    it { expect(subject.total_todo).to eq(1) }
  end

  describe '#already_done_tasks' do
    let(:other_user) { create(:user) }
    let!(:task) { create(:task, user: other_user, assignee: user, completed: true)}

    it { expect(subject.already_done_tasks).to eq(1) }
  end

end
