class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tasks, dependent: :destroy

  enum role: { admin: 0, regular_user: 1 } 

  def total_todo
    tasks.where(completed: false).count
  end

  def already_done_tasks
    tasks.where(completed: true).count
  end
end
