class ToppagesController < ApplicationController
  def index
    @users = User.order(id: :desc)
    @imageposts = Imagepost.order(id: :desc)
    
  end
end
