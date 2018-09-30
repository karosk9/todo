class Task < ApplicationRecord
  belongs_to :user

  scope :done_yesterday, -> { where("Date(finished_at) = ?", 'yesterday') }
end
