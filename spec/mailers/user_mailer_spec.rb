require 'rails_helper'

describe UserMailer, type: :mailer do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user, finished_at: DateTime.now - 1.day) }
  let(:mail) { UserMailer.daily_summary(user.id) }

  describe 'daily summary' do

    it 'sets correct headers' do
      expect(mail.subject).to eq('Daily summary')
      expect(mail.to).to eq(["#{user.email}"])
      expect(mail.from).to eq(['todo@example.com'])
    end

    describe 'body' do
      let(:body) { CGI.unescapeHTML(mail.body.to_s) }

      it 'sends information about done tasks' do
        expect(body).to have_content('Tasks done: 1')
        expect(body).to have_content(task.title)
      end
    end
  end
end
