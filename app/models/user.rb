class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tasks
  has_many :assigned_tasks, foreign_key: 'assignee_id', class_name: 'Task'

  enum role: { admin: 0, regular_user: 1 }

  validates :email, email: true

  def total_todo
    assigned_tasks.where(completed: false).count
  end

  def already_done_tasks
    assigned_tasks.where(completed: true).count
  end
end
