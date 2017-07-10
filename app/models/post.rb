# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  question   :text
#  latitude   :float
#  longitude  :float
#  user_id    :integer
#  active     :boolean
#  emjoi      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy

  #9 July 2017
  #By: Andy
  #Geocode location to lat long
  geocoded_by :location
  after_validation :geocode

  #9 July 2017
  #By: Michelle
  #To add relationship between vote and post
  has_many :votes, dependent: :destroy

  #julian code
  # def self.search(search)
  #
  # if search
  #   search = search.gsub(/[^a-zA-Z ]/,'').gsub(/ +/,' ')
  #   self.where("question like ?", "%#{search}%")
  # else
  #   self.all
  # end
  # end
  #end julian code

  def self.text_search query

  # old new code
  # if query.present?
  #     where("question @@ :q", q: query)
  #   else
  #     self.all
  #   end


  # location search .near

  if query.present?



  rank = <<-RANK
  ts_rank(to_tsvector(question), plainto_tsquery(#{sanitize(query)}))
  RANK
  # raise 'hell'
  Post.near([33, 155], 50, :units => :km)

  where("question @@ :q", q: query).order("#{rank} desc")
  else
  self.all
  end


  end

end
