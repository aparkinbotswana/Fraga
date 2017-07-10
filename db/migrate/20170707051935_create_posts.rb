class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :question
      t.float :latitude
      t.float :longitude
      t.integer :user_id
      t.boolean :active
      t.text :emjoi

      t.timestamps
    end
  end
end
