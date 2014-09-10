class AddUserIdToAccessCodesAndRefreshCodes < ActiveRecord::Migration
  def change
    add_column :access_codes, :user_id, :integer
    add_column :refresh_codes, :user_id, :integer
  end
end
