class CreateSpriteItems < ActiveRecord::Migration
  def change
    create_table :sprite_items do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.text :description
      t.text :body
      t.text :free_space1
      t.text :free_space2
      t.datetime :pub_date
      t.datetime :mod_date
      t.datetime :exp_date
      t.integer :pr_flg, limit: 1, default: 0
      t.string :pr_title
      t.string :pr_url
      t.string :address
      t.string :status, null: false, default: 'private'

      t.timestamps null: false
    end
  end
end