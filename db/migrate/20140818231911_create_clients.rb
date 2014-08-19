class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :api_key
      t.string :api_secret
      t.string :website_url
      t.string :redirect_uri
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
