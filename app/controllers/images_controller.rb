class ImagesController < ApplicationController

  def index
    @images = Image.all.order('created_at DESC')
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to @image
    else
      render 'new'
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  def tagged
    return if params[:tag].blank?

    @images = Image.tagged_with(params[:tag])
    @tag = params[:tag]
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    redirect_to images_path
  end

  private

  #strong params
  def image_params
    params.require(:image).permit(:url, :tag_list)
  end
end
