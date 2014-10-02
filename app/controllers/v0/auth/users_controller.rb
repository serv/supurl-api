class V0::Auth::UsersController < ApplicationController
  def create
    pry
    @user = User.new(user_param)
  end

  private

    def user_param
      params.require(:user).permit(:username,
                                   :email,
                                   :password,
                                   :password_confirmation)
    end
end
