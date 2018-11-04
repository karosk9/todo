require 'rails_helper'

describe TaskPolicy, type: :policy do
  subject { TaskPolicy.new(user, task) }

  context 'current user is creator of task' do
    let!(:task) { create(:task, user: user) }
    let(:user) { create(:user) }

    it { is_expected.to permit(:manageable) }
    it { is_expected.to permit(:actionable) }
  end

  context 'current user is assigned to task' do
    let!(:task) { create(:task, user: creator, assignee: user) }
    let(:creator) { create(:user) }
    let(:user) { create(:user) }

    it { is_expected.to permit(:manageable) }
    it { is_expected.not_to permit(:actionable) }
  end

  context 'current user has admin role' do
    let!(:task) { create(:task, user: user) }
    let(:user) { create(:user, role: 'admin') }

    it { is_expected.to permit(:manageable) }
    it { is_expected.to permit(:actionable) }
  end

  context 'current user is not creator, assignee nor admin' do
    let!(:task) { create(:task, user: user_2) }
    let(:user) { create(:user) }
    let(:user_2) { create(:user) }

    it { is_expected.not_to permit(:manageable) }
    it { is_expected.not_to permit(:actionable) }
  end
end
