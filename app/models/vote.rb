# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Vote < ApplicationRecord
  #9 July 2017
  #By: Michsmelle
  #To add relationship between vote and post
  belongs_to :post, optional: true
  belongs_to :user
  belongs_to :comment, optional: true


end
