require 'rails_helper'

describe 'Task', type: :model do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  describe 'validations' do
    it 'is not valid without title' do
      task = Task.new
      expect(task).to_not be_valid
    end

    context 'is valid' do
      let(:user) { create(:user) }
      let!(:task) { create(:task, user: user) }

      it { expect(task).to be_valid }
      it { expect(task).to validate_presence_of(:title) }
    end
  end

  describe 'associations' do
    it { expect(task).to belong_to(:user) }
  end
end
