class ImagesController < ApplicationController

  add_flash_types :success, :error

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
      flash[:success] = "image created successfully"
    else
      render 'new'
    end
  end

  def show
    @image = Image.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render 'notfound'
  end

  def destroy
    TagService.delete delete_params
    redirect_to images_path
    flash[:error] = "image deleted successfully"
  rescue ActiveRecord::RecordNotFound => e
    render 'notfound'
  end

  private

  #strong params
  def image_params
    params.require(:image).permit(:url, :tag_list)
  end

  def tag_params
    params.permit(:tags)
  end

  def delete_params
    params.permit(:id)[:id]
  end
end
