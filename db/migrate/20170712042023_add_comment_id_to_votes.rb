class AddCommentIdToVotes < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :comment_id, :integer
    add_column :comments, :score, :integer, default: 0
  end
end
