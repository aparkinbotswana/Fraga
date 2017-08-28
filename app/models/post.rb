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
#  location   :string
#

class Post < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user, optional: true

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


  def self.location_search(loc)
    # puts loc
    # binding.pry
    Post.near([loc[0].data["geometry"]["location"]["lat"], loc[0].data["geometry"]["location"]["lng"]], 3, :units => :km)
  end

  def self.user_search(lat, lng)
    Post.near([lat, lng], 3, :units => :km)
  end

  def self.text_search(query, user)
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

      # Post.near([user.latitude, user.longitude], 50, :units => :km).where("question @@ :q", q: query).order("#{rank} desc")
      Post.near([-33.8688, 151.2093], 8000000, order: 'distance').where("question @@ :q", q: query).order("#{rank} desc")
    else
      self.all
    end
  end

  # Michelle / 11 July
  # for upvotes/downvotes
  def upvotes
    votes.sum(:upvote)
  end

  def downvotes
    votes.sum(:downvote)
  end

end
