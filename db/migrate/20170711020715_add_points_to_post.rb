class AddPointsToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :score, :integer, default: 0
  end
end
