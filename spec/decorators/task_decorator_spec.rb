require 'rails_helper'

describe TaskDecorator do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user).decorate }

  describe '#check_if_done' do
    let(:assignee) { create(:user) }
    let(:admin) { create(:user, role: 'admin') }
    let(:other_user) { create(:user) }
    let!(:task_2) { create(:task, assignee: assignee).decorate }

    context 'current user is creator of task' do
      before do
        login_as(user)
        visit '/'
      end

      it "has visible 'Done!' button" do
        expect(page).to have_selector(:link_or_button, 'Done!', count: 1)
      end

      context 'task is completed' do
        let(:task) { create(:task, user: user, completed: true) }
        it "has visible 'Restore' button" do
          expect(page).to have_selector(:link_or_button, 'Restore', count: 1)
        end
      end
    end

    context 'current user is assigned to task' do

      before do
        login_as(assignee)
        visit '/'
      end

      it "has visible 'Done!' button" do
        expect(page).to have_selector(:link_or_button, 'Done!', count: 1)
      end

      context 'task is completed' do
        let!(:task_2) { create(:task, assignee: assignee, completed: true).decorate }

        it "has visible 'Restore' button" do
          expect(page).to have_selector(:link_or_button, 'Restore', count: 1)
        end
      end
    end

    context 'current user is admin' do
      before do
        login_as(admin)
        visit '/'
      end

      it 'has visible done button' do
        expect(page).to have_selector(:link_or_button, 'Done!', count: 2)
      end
    end

    context 'current user has no permission to manage the task' do
      before do
        login_as(other_user)
        visit '/'
      end

      it 'has not visible done button' do
        expect(page).not_to have_selector(:link_or_button, 'Done!')
      end
    end

    describe '#created' do
      let!(:task) { create(:task, user: user, created_at: 2.days.ago).decorate }
      it 'returns time ago in words' do
        expect(task.created).to eq('2 days ago')
      end
    end

    describe '#deadline_time' do
      context 'done' do
        let!(:task) { create(:task, user: user, completed: true).decorate }
        it 'displays proper deadline' do
          expect(task.deadline_time).to eq('done')
        end
      end

      context 'done' do
        let!(:task) { create(:task, user: user, completed: true).decorate }
        it 'displays proper deadline' do
          expect(task.deadline_time).to eq('done')
        end
      end

      context 'no deadline' do
        let!(:task) { create(:task, user: user, deadline: nil).decorate }
        it 'displays proper deadline' do
          expect(task.deadline_time).to eq('no deadline')
        end
      end

      context 'today' do
        let!(:task) { create(:task, user: user, deadline: Date.today).decorate }
        it 'displays proper deadline' do
          expect(task.deadline_time).to eq('today')
        end
      end

      context 'in couple of days' do
        let!(:task) { create(:task, user: user, deadline: 2.days.from_now).decorate }
        it 'displays proper deadline' do
          expect(task.deadline_time).to eq('in 2 days')
        end
      end
    end

    describe '#finish_time' do
      it { expect(task.finish_time).to eq('in progress') }

      context 'task is finished' do
        let!(:task) { create(:task, user: user, updated_at: 2.days.ago, completed: true).decorate }
        it { expect(task.finish_time).to eq('2 days ago') }
      end
    end

    describe '#decorated_title' do
      let!(:task) { create(:task, user: user, title: nil).decorate }
      it { expect(task.decorated_title).to eq('No title') }
    end
  end
end
