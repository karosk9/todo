class AddAssigneeToTask < ActiveRecord::Migration[5.1]
  def change
    add_reference :tasks, :assignee, references: :users, index: true
    add_foreign_key :tasks, :users, column: :assignee_id
  end
end
