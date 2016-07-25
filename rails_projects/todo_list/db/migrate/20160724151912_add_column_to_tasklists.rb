class AddColumnToTasklists < ActiveRecord::Migration
  def change
    add_column :tasklists, :user_id, :string
  end
end
