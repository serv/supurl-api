class AddAccessRefreshCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_code_id, :integer
    add_column :users, :refresh_code_id, :integer
  end
end
