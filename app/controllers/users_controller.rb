class UsersController < ApplicationController
  def index
    @users = User.all_paged(params[:page])
  end
end