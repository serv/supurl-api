class FixRefreshTokenInAccessCodes < ActiveRecord::Migration
  def change
    rename_column :access_codes, :refresh_token_id, :refresh_code_id
  end
end
