class Vote < ApplicationRecord
  #9 July 2017
  #By: Michsmelle
  #To add relationship between vote and post
  belongs_to :post
  belongs_to :user

end
