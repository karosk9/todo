class Task < ApplicationRecord
  before_validation :set_assignee

  belongs_to :user
  belongs_to :assignee, class_name: :User, foreign_key: :assignee_id

  paginates_per 20

  scope :done_yesterday, -> { where('Date(finished_at) = ?', 'yesterday') }

  private

  def set_assignee
    self.assignee = self.user unless assignee.present?
  end
end
