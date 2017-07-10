# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :text
#  password_digest :string
#  latitude        :float
#  longitude       :float
#  image           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy


  has_secure_password
  validates :username, presence: true, uniqueness: true, length: {minimum: 2}

end
