class CreateAccessCodes < ActiveRecord::Migration
  def change
    create_table :access_codes do |t|
      t.string :token
      t.datetime :expires_at
      t.integer :client_id
      t.integer :refresh_token_id

      t.timestamps
    end
  end
end
