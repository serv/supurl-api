class CreateTaggables < ActiveRecord::Migration
  def change
    create_table :taggables do |t|
      t.integer :tag_id
      t.integer :link_id

      t.timestamps
    end
  end
end
