class CreateSpritePrefectures < ActiveRecord::Migration
  def change
    create_table :sprite_prefectures do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end