class UsersController < ApplicationController



  def index
    @users = User.all
  end

  private
  def post_params

    params.require(:invoice).permit(:name, :adress, :ic)
  end
end
