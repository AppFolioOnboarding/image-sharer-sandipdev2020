require 'test_helper'

VALID_URL ||= 'https://www.gstatic.com/webp/gallery3/1.png'.freeze


class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_index_path
    get images_path
    assert_response :ok
    assert_select 'a', 'Add image'
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
    assert_difference('Image.count') do
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
end
