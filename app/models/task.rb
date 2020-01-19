class Task < ApplicationRecord
  belongs_to :user

  paginates_per 20

  scope :done_yesterday, -> { where('Date(finished_at) = ?', 'yesterday') }
end
