class Task < ApplicationRecord
  belongs_to :user
  belongs_to :assignee, class_name: :User, foreign_key: :assignee_id

  paginates_per 20

  scope :done_yesterday, -> { where('Date(finished_at) = ?', 'yesterday') }
end
