class CreateSpriteContents < ActiveRecord::Migration

  def change
    create_table :sprite_contents do |t|
      t.string :name
      t.string :type
      t.string :slug
      t.text :note
      t.string :ancestry
      t.integer :parented_id, limit: 3
      t.integer :ancestry_depth, default: 0
      t.integer :position, limit: 2
      t.boolean :is_directory, default: 0

      t.string :status, null: false, default: 'private'

      t.timestamps null: false
    end
    add_index :sprite_contents, :slug
    add_index :sprite_contents, :ancestry
  end

end
