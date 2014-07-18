class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :href
      t.text   :comment

      t.timestamps
    end
  end
end
