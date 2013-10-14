class UsersController < Devise::RegistrationsController


  def index
    @user = User.find(params[:id])
  end
end
