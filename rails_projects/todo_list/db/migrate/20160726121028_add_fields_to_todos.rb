class AddFieldsToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :due_date, :string
    add_column :todos, :priority, :integer
    add_column :todos, :alert, :boolean
  end
end
