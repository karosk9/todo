require 'rails_helper'

describe TasksController, type: :request do
  describe 'GET /tasks' do
    let(:user) { create(:user) }

    subject { get '/tasks' }

    before do
      login_as(user)
    end

    it 'responds with success status (200)' do
      subject
      expect(response).to have_http_status(:ok)
    end
  end
end
