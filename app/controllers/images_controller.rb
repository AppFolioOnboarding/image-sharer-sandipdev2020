class ImagesController < ApplicationController

  def index

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
  rescue ActiveRecord::RecordNotFound => e
    render 'notfound'
  end

  private

  #strong params
  def image_params
    params.require(:image).permit(:url)
  end
end
