class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_if_admin, only: [:edit, :destroy]
  before_action :check_if_logged_in, except: [:map, :do_search, :show]

  # GET /posts
  # GET /posts.json

# Michelle - for up/down votes
  def check_score
    score = @post.upvotes - @post.downvotes
    # raise 'hell'
    @post.update_attribute(:score, score)
  end

  def make_request
    respond_to do |format|
    #   # if the response format is html, redirect as usual
      format.html { redirect_to root_path }
    #   # if the response format is javascript, do something else...
      format.js { }
    end

  end
  def index
    @posts = Post.all
   end

   def do_search
    #  @users = User.all
     @posts = Post.text_search(params[:query], @current_user)
    #  response = { :users => @users, :posts => @posts }
     respond_to do |format|
       format.html { render :do_search }
       format.json { render json: @posts, include: [:user] }

     end
   end


   #
  #  def do_search
  #    @users = User.all
  #    @posts = Post.text_search(params[:query], @current_user)
  #    respond_to do |format|
  #      format.html { render :do_search }
  #      format.json { render json: @posts }
   #
   #
  #
  #    end
  #  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @posts = Post.all
    @post = Post.find params["id"]
    @comment = Comment.new
    @user = User.all
    # raise 'hell'

  end

  def map
    @posts = Post.all
    @hash = Gmaps4rails.build_markers(@posts) do |post, marker|
    location_link = view_context.link_to post.question, post_path(post.id)
    marker.lat post.latitude
    marker.lng post.longitude
    marker.picture({
      :url => ActionController::Base.helpers.asset_path("assets/mapicons/#{post.emjoi}.png"),
      width: 60,
      height: 60,
      })

      # :url => ActionController::Base.helpers.asset_path("repository_icon_for_map.png"),


    # marker.picture({
    #         #  "picture" => view_context.image_path('assets/happy.png'),
    #          "picture" => "assets/alien.png",
    #         #  "picture" => "/images/#{happy}.png",
    #          "width" => 32,
    #          "height" => 37
    #      })
    marker.json({:id => post.id })
    marker.infowindow "<p><strong><u>#{location_link}</u></strong></p><p></p><p>#{post.location}</p>"
    end
  end

  # GET /posts/new
  def new


    @post = Post.new

    # Detect IP and obtain location information through Geocoder
    ip = request.remote_ip;
    loc = Geocoder.search('114.75.87.227') #for local server testing, comment this out and use line below before deployment to Heroku
    # loc = Geocoder.search(ip)

    @hash = Gmaps4rails.build_markers(@post) do |post, marker|
    marker.lat loc[0].data['latitude']
    marker.lng loc[0].data['longitude']
    marker.json({:id => post.id })
    end

  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    # Michelle - to create post in current user's name
    @post = @current_user.posts.new(post_params)
    # @post = Post.new(post_params)
    # Get user ip parse through geocoder to get lat/long. use this as default if location field is left blanque.

    ip = request.remote_ip;
    loc = Geocoder.search(ip)

    if @post.location == ""
       @post.latitude = loc[0].data['latitude']
       @post.longitude = loc[0].data['longitude']
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #9 July 2017
    #By: Michelle
    #For upvoting
    def upvote
      @post = Post.find_by(id: params[:id])
      # raise 'hell'

      # the following line to be uncommented when we go live to allow for 1 vote per user
      # Vote.find_or_create_by(post: @post, user: @current_user)
      # Vote.find_or_create_by(upvote: 1, post: @post, user: @current_user)
      Vote.create(upvote: 1, post: @post, user: @current_user)
      check_score()
      make_request()
      # redirect_to posts_path
    end

    #11 July 2017
      #By: Michelle
      #For downvotes
    def downvote
      @post = Post.find_by(id: params[:id])
      # Vote.find_or_create_by(downvote: 1, post: @post, user: @current_user)
      Vote.create(downvote: 1, post: @post, user: @current_user)
      check_score()
      make_request()
      # redirect_to posts_path
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:question, :location, :user_id, :active, :emjoi)
    end
end
