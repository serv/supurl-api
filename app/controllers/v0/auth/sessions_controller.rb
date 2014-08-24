class V0::Auth::SessionsController < ApplicationController
  def sign_in
    @user = User.new
  end

  def create
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
