class CreateAuthorizationCodes < ActiveRecord::Migration
  def change
    create_table :authorization_codes do |t|
      t.string :token
      t.datetime :expires_at
      t.integer :client_id

      t.timestamps
    end
  end
end
