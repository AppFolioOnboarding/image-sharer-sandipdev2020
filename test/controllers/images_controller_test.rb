require 'test_helper'

VALID_URL ||= 'https://www.gstatic.com/webp/gallery3/1.png'.freeze
VALID_FLOWER_TAG ||= 'flower'.freeze
VALID_PLANT_TAG ||= 'plant'.freeze
EMPTY_TAG ||= ''.freeze

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_index_path
    get images_path
    assert_response :ok
    assert_select 'a', 'Add new image'
  end

  def test_index_path_with_image_ordered
    Image.create(url: VALID_URL)
    Image.create(url: VALID_URL)
    get images_path
    assert_select 'label:first-child' do |label|
      assert_includes label.text(), Image.last.id.to_s
    end
  end

  def test_index_path_tags
    Image.create(url: VALID_URL, tag_list: VALID_FLOWER_TAG)
    get images_path
    assert_select '.tag-list' do |tag|
      assert_equal [VALID_FLOWER_TAG], tag.map(&:text)
    end
  end

  def test_index_path_images_has_small_display_size
    Image.create(url: VALID_URL)
    Image.create(url: VALID_URL)
    get images_path
    assert_select '.image-small'
  end

  def test_new_image_path
    get new_image_path
    assert_response :ok
  end

  def test_create_new_image_with_redirect
    assert_difference('Image.count') do
      post '/images', params: { image: { url: VALID_URL } }
    end
    assert_response :redirect
    assert_redirected_to image_path(Image.last)
    assert_includes Image.last.url, VALID_URL
    follow_redirect!
    assert_select '.alert', 'image created successfully'
  end

  def test_create_new_image_with_invalid_url
    assert_no_difference('Image.count') do
      post '/images', params: { image: { url: ' ' } }
    end
    assert_response :ok
  end

  def test_show
    Image.create!(url: VALID_URL)
    get image_path(Image.last)
    assert_response :ok
    assert_includes response.body, VALID_URL
    assert_equal Image.last.url, VALID_URL
  end

  def test_show_when_image_id_not_found
    get image_path('does not exist')
    assert_response :ok
    assert_includes response.body, 'requested image is not found'
  end

  def test_create_new_image_with_tags
    assert_difference('Image.count') do
      post '/images', params: { image: { url: VALID_URL, tag_list: VALID_FLOWER_TAG } }
    end
    assert_response :redirect
    assert_redirected_to image_path(Image.last)
    assert_includes Image.last.url, VALID_URL
    follow_redirect!
    assert_select 'a[href=?]',  root_path(tags: VALID_FLOWER_TAG)
  end

  def test_index_with_unique_tags
    assert_difference('Image.count', 2) do
      post '/images', params: { image: { url: VALID_URL, tag_list: VALID_FLOWER_TAG } }
      post '/images', params: { image: { url: VALID_URL, tag_list: VALID_PLANT_TAG } }
    end
    get root_path(tags: VALID_PLANT_TAG)
    assert_select 'a[href=?]',  root_path(tags: VALID_PLANT_TAG)
    assert_not_includes response.body, VALID_FLOWER_TAG
  end

  def test_index_with_empty_tags
    assert_difference('Image.count', 2) do
      post '/images', params: { image: { url: VALID_URL, tag_list: VALID_FLOWER_TAG } }
      post '/images', params: { image: { url: VALID_URL, tag_list: VALID_PLANT_TAG } }
    end
    get root_path(tags: EMPTY_TAG)
    assert_select 'a[href=?]',  root_path(tags: VALID_PLANT_TAG)
    assert_select 'a[href=?]',  root_path(tags: VALID_FLOWER_TAG)
  end

  def test_index_with_unique_tags
    assert_difference('Image.count', 2) do
      post '/images', params: { image: { url: VALID_URL, tag_list: VALID_FLOWER_TAG } }
      post '/images', params: { image: { url: VALID_URL, tag_list: VALID_PLANT_TAG } }
    end
    get root_path(tags: VALID_PLANT_TAG)
    assert_select 'a[href=?]',  root_path(tags: VALID_PLANT_TAG)
    assert_not_includes response.body, VALID_FLOWER_TAG
  end

  def test_index_with_empty_tags
    assert_difference('Image.count', 2) do
      post '/images', params: { image: { url: VALID_URL, tag_list: VALID_FLOWER_TAG } }
      post '/images', params: { image: { url: VALID_URL, tag_list: VALID_PLANT_TAG } }
    end
    get root_path(tags: EMPTY_TAG)
    assert_select 'a[href=?]',  root_path(tags: VALID_PLANT_TAG)
    assert_select 'a[href=?]',  root_path(tags: VALID_FLOWER_TAG)
  end

  def test_image_destroy
    Image.create!(url: VALID_URL, tag_list: VALID_FLOWER_TAG)
    assert_difference('Image.count', -1) do
      delete image_path(Image.last.id)
    end
    assert_redirected_to images_path
    follow_redirect!
    assert_select '.alert', 'image deleted successfully'
  end

  def test_image_destroy_raises_exception_for_already_deleted_image
    Image.create!(url: VALID_URL, tag_list: VALID_FLOWER_TAG)
    id = Image.last.id
    assert_difference('Image.count', -1) do
      delete image_path(Image.last.id)
    end
    assert_no_difference('Image.count') do
      assert_raises(Exception) {
        delete image_path(Image.last.id)
      }
    end
  end
end
