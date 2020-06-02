class TagService
  class << self
    def list_image(params)
      if params[:tags].present?
        Image.tagged_with(params[:tags].split(',')).order('created_at DESC')
      else
        Image.all.order('created_at DESC')
      end
    end

    def delete(id)
      image = Image.find(id)
      image.destroy
    end
  end
end
