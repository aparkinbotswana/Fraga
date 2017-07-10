class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.text :username
      t.string :password_digest
      t.float :latitude
      t.float :longitude
      t.string :image

      t.timestamps
    end
  end
end
