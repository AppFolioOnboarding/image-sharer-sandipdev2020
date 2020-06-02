require 'test_helper'

VALID_URL ||= 'https://www.gstatic.com/webp/gallery3/1.png'.freeze
VALID_FLOWER_TAG ||= 'flower'.freeze
VALID_PLANT_TAG ||= 'plant'.freeze
EMPTY_TAG ||= ''.freeze
MULTIPLE_TAGS ||=%w[flower plant].freeze

class TagServiceTest < ActiveSupport::TestCase
  def test_list_image
    Image.create!(url: VALID_URL, tag_list: VALID_FLOWER_TAG)
    Image.create!(url: VALID_URL, tag_list: VALID_PLANT_TAG)
    images = TagService.list_image(tags: VALID_FLOWER_TAG)
    assert_equal 1, images.length()
    assert_equal Image.first, images[0]
  end

  def test_list_image_with_empty_tag
    Image.create!(url: VALID_URL, tag_list: VALID_FLOWER_TAG)
    Image.create!(url: VALID_URL, tag_list: VALID_PLANT_TAG)
    images = TagService.list_image(tags: EMPTY_TAG)
    assert_equal 2, images.length()
  end

  def test_list_image_with_multiple_tags
    Image.create!(url: VALID_URL, tag_list: MULTIPLE_TAGS)
    images = TagService.list_image(tags: MULTIPLE_TAGS)
    assert_equal Image.last, images[0]
  end

  def test_list_image_with_order
    Image.create!(url: VALID_URL, tag_list: VALID_FLOWER_TAG)
    Image.create!(url: VALID_URL, tag_list: VALID_PLANT_TAG)
    images = TagService.list_image(tags: EMPTY_TAG)
    assert_equal Image.last, images[0]
    assert_equal Image.first, images[1]
  end

  def test_delete_image
    Image.create!(url: VALID_URL, tag_list: 'flower')
    assert_difference('Image.count', -1) do
      TagService.delete Image.last.id
    end
  end

  def test_delete_image_when_image_not_found
    Image.create!(url: VALID_URL, tag_list: 'flower')
    assert_difference('Image.count', -1) do
      TagService.delete Image.last.id
    end
    assert_no_difference('Image.count') do
      assert_raises(Exception) {
        TagService.delete Image.last.id
      }
    end
  end
end
