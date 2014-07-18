class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :display_name
      t.string :shortcut

      t.timestamps
    end
  end
end
