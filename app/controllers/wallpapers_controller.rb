class WallpapersController < ApplicationController
  before_action :set_wallpaper, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:temp_pic]
  before_action :authenticate_user!, only: [:new,:edit], notice: 'Sign in First Please'
  require 'will_paginate/array'
  WillPaginate.per_page = 15
  # GET /wallpapers
  # GET /wallpapers.json
  def index
    if params[:color]
      @header=params[:color]
      @wallpapers=Wallpaper.where('color LIKE ?',params[:color]).reverse_order.paginate(:page => params[:page])
    elsif params[:tag]
      @header=params[:tag]
      @wallpapers=[]
      @tags=params[:tag].split(",")
      if params[:tag].end_with? 's'
        @s_wallpapers=Wallpaper.tagged_with([params[:tag].chomp("s")],parse: true, :match_all => false, :any => true).reverse_order
      else
        @s_wallpapers=Wallpaper.tagged_with([params[:tag]+"s"],parse: true, :match_all => false, :any => true).reverse_order
      end
      @non_s_wallpapers=Wallpaper.tagged_with([params[:tag]],parse: true, :match_all => false, :any => true).reverse_order
      @wallpapers=(@non_s_wallpapers+@s_wallpapers).paginate(:page => params[:page])

    else
      @header="Newiest"
      @wallpapers = Wallpaper.all.reverse_order.paginate(:page => params[:page])
    end
  end

  # GET /wallpapers/1
  # GET /wallpapers/1.json
  def show
    if @wallpaper.image.exists? == false
      gon.src= @wallpaper.image.url.to_s
      @size=FastImage.size(@wallpaper.image.url)
    end
  end

  # GET /wallpapers/new
  def new
    @wallpaper = current_user.wallpapers.build
  end

  # GET /wallpapers/1/edit
  def edit
    if current_user != @wallpaper.user
      flash[:error]= 'Thats Not Yours!!'
      redirect_to root_path
    end
  end

  def add_tags
    @new_tags=params[:tags]
    @id=params[:id]
    @wallpaper=Wallpaper.find(@id)
    @wallpaper.tag_list.add(@new_tags,parse: true)
    @wallpaper.save
    redirect_to :back
  end

  # POST /wallpapers
  # POST /wallpapers.json
  def create
    @wallpaper = current_user.wallpapers.build(wallpaper_params.merge(image:current_user.temp_pic))
    respond_to do |format|
      if @wallpaper.save
        current_user.temp_pic.clear
        current_user.save
        format.html { redirect_to @wallpaper, notice: 'Wallpaper was successfully created.' }
        format.json { render :show, status: :created, location: @wallpaper }
      else
        format.html { render :new }
        format.json { render json: @wallpaper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wallpapers/1
  # PATCH/PUT /wallpapers/1.json
  def update
    respond_to do |format|
      if @wallpaper.update(wallpaper_params)
        format.html { redirect_to @wallpaper, notice: 'Wallpaper was successfully updated.' }
        format.json { render :show, status: :ok, location: @wallpaper }
      else
        format.html { render :edit }
        format.json { render json: @wallpaper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallpapers/1
  # DELETE /wallpapers/1.json
  def destroy
    @wallpaper.destroy
    respond_to do |format|
      format.html { redirect_to wallpapers_url, notice: 'Wallpaper was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote
    @wallpaper=Wallpaper.find(params[:id])
    if current_user.voted_up_on? @wallpaper
      @wallpaper.unliked_by current_user
    else
      @wallpaper.liked_by current_user
    end


    respond_to do |format|
    format.xml  { render :xml => @wallpaper }
    format.json { render :json => (@wallpaper.get_upvotes.size) }
  end
end
  def temp_pic
    @user=current_user
    @user.temp_pic=params[:file]
    @user.save
    respond_to do |format|
        format.html {  }
        format.json { render json:" @wallpaper.errors, status: :unprocessable_entity "}
    end
  end

  def show_tags
    @tags=ActsAsTaggableOn::Tag.most_used(10000).paginate(:page => params[:page])
  end

  def home

  end
  def guide
  end
  def file1
  end
  def file2
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallpaper
      @wallpaper = Wallpaper.where("title LIKE ?",params[:id]).last
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wallpaper_params
      params.require(:wallpaper).permit(:cat, :color, :picture_id, :title,:image,:tag_list)
    end
end
