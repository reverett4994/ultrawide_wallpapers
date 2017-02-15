class UserController < ApplicationController

  def show
    @user=User.where("username LIKE ?",params[:username])
    @user=@user[0]
  end

end
