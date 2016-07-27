class AddColumnToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :tasklist_id, :integer
 
  end
end
