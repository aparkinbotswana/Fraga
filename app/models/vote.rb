# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vote < ApplicationRecord
  #9 July 2017
  #By: Michsmelle
  #To add relationship between vote and post
  belongs_to :post
  belongs_to :user


end
