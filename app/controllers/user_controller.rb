class UserController < ApplicationController
  require 'will_paginate/array'
  WillPaginate.per_page = 12

  def show
    @user=User.where("username LIKE ?",params[:username])
    @user=@user[0]
    @wallpapers=@user.find_liked_items.paginate(:page => params[:page])
  end
  
  def submitted
    @user=User.where("username LIKE ?",params[:username])
    @user=@user[0]
    @wallpapers=@user.wallpapers.paginate(:page => params[:page])
  end

end
