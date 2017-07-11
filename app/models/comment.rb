# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :integer
#  commentable_type :string
#

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user, optional: true
  has_many :comments, as: :commentable
end
