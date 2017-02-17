class WallpapersController < ApplicationController
  before_action :set_wallpaper, only: [:show, :edit, :update, :destroy]
  require 'will_paginate/array'
  WillPaginate.per_page = 12
  # GET /wallpapers
  # GET /wallpapers.json
  def index
    if params[:color]
      @wallpapers=Wallpaper.where('color LIKE ?',params[:color]).paginate(:page => params[:page])
    elsif params[:cat]
      @wallpapers=Wallpaper.where('cat LIKE ?',params[:cat]).paginate(:page => params[:page])
    else
      @wallpapers = Wallpaper.all.paginate(:page => params[:page])
    end
  end

  # GET /wallpapers/1
  # GET /wallpapers/1.json
  def show
    if @wallpaper.image.exists?
      gon.src= @wallpaper.image.url.to_s
    else
      gon.src="https://s3.amazonaws.com/ultrawidewallpapers/#{@wallpaper.picture_id}.jpg"
    end
  end

  # GET /wallpapers/new
  def new
    @wallpaper = current_user.wallpapers.build
  end

  # GET /wallpapers/1/edit
  def edit
  end

  # POST /wallpapers
  # POST /wallpapers.json
  def create
    @wallpaper = current_user.wallpapers.build(wallpaper_params)

    respond_to do |format|
      if @wallpaper.save
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallpaper
      @wallpaper = Wallpaper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wallpaper_params
      params.require(:wallpaper).permit(:cat, :color, :picture_id, :title,:image)
    end
end
