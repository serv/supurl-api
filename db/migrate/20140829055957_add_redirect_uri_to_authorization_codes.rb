class AddRedirectUriToAuthorizationCodes < ActiveRecord::Migration
  def change
    add_column :authorization_codes, :redirect_uri, :string
  end
end
