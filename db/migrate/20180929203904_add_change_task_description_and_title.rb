class AddChangeTaskDescriptionAndTitle < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :content, :text
    rename_column :tasks, :description, :title
    add_column :tasks, :finished_at, :datetime
  end
end
