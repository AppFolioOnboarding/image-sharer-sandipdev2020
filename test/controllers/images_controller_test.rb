require 'test_helper'

VALID_URL ||= 'https://www.gstatic.com/webp/gallery3/1.png'.freeze
VALID_TAG ||= '/tagged?tag=flower'.freeze
EMPTY_TAG ||= '/tagged?tag=empty'.freeze
BLANK_TAG ||= '/tagged?tag='.freeze

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
    assert_difference('Image.count', 1) do
      post '/images', params: { image: { url: VALID_URL } }
    end
    assert_response :redirect
    assert_redirected_to image_path(Image.last)
    assert_includes Image.last.url, VALID_URL
  end

  def test_create_new_image_with_invalid_url
    assert_no_difference('Image.count') do
      post '/images', params: { image: { url: ' ' } }
    end
    assert_response :ok
  end

  def test_view_image
    Image.create!(url: VALID_URL)
    get image_path(Image.last)
    assert_response :ok
    assert_includes response.body, VALID_URL
    assert_equal Image.last.url, VALID_URL
  end

  def test_create_new_image_with_tags
    assert_difference('Image.count', 1) do
      post '/images', params: { image: { url: VALID_URL, tag_list: 'flower' } }
    end
    assert_response :redirect
    assert_redirected_to image_path(Image.last)
    assert_includes Image.last.url, VALID_URL
    follow_redirect!
    assert_select 'a[href=?]', VALID_TAG
  end

  def  test_create_new_image_with_tags_and_jump_to_tag_page
    Image.create!(url: VALID_URL, tag_list: 'flower')
    get VALID_TAG
    assert_select 'img[src=?]', VALID_URL
  end

  def  test_show_empty_page_for_non_existent_tags
    get EMPTY_TAG
    assert_not_includes  response.body, 'img'
  end

  def  test_error_from_empty__tag_page
    exception = assert_raises(Exception) {get BLANK_TAG}
    assert_equal exception.message, "undefined method `each' for nil:NilClass"
  end

  def test_image_delete
    Image.create!(url: VALID_URL, tag_list: 'flower')
    assert_difference('Image.count', -1) do
      delete image_path(Image.last.id)
    end
  end

  def test_image_delete_raises_exception_for_already_deleted_image
    Image.create!(url: VALID_URL, tag_list: 'flower')
    assert_difference('Image.count', -1) do
      delete image_path(Image.last.id)
    end
    assert_raises(Exception) {delete image_path(Image.last.id)}
  end
end
