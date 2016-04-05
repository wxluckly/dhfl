class UpdateColumnToUser < ActiveRecord::Migration
  def change
  	remove_column :users, :category, :string
  	add_column :users, :is_admin, :boolean, default: false
  end
end
