require 'rails_helper'

describe 'Task', type: :model do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  describe 'associations' do
    it { expect(task).to belong_to(:user) }
  end
end
