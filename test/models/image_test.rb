require 'test_helper'

VALID_URL ||= 'https://www.gstatic.com/webp/gallery3/1.png'.freeze
INVALID_URL ||= 'https://www.google.com'.freeze
EMPTY_URL ||= ''.freeze

class ImagesControllerTest < ActiveSupport::TestCase
  def test_valid_image
    @image = Image.new(url: VALID_URL)
    assert_predicate @image, :valid?
  end

  def test_image_with_empty_url
    @image = Image.new(url: EMPTY_URL)
    assert_not_predicate @image, :valid?
  end

  def test_image_with_invalid_url
    @image = Image.new(url: INVALID_URL)
    assert_not_predicate @image, :valid?
  end
end
