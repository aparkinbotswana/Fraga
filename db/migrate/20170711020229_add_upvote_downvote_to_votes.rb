class AddUpvoteDownvoteToVotes < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :upvote, :integer, default: 0
    add_column :votes, :downvote, :integer, default: 0


  end
end
