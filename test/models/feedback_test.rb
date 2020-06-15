require 'test_helper'

VALID_NAME ||= 'https://www.gstatic.com/webp/gallery3/1.png'.freeze
EMPTY_NAME ||= ''.freeze
VALID_COMMENT ||= 'https://www.google.com'.freeze
EMPTY_COMMENT ||= ''.freeze

class FeedbackTest < ActiveSupport::TestCase
  def test_valid_feedback
    feedback = Feedback.new(name: VALID_NAME, comment: VALID_COMMENT)
    assert_predicate feedback, :valid?
  end

  def test_feedback_with_empty_name
    feedback = Feedback.new(name: EMPTY_NAME, comment: VALID_COMMENT)
    assert_not_predicate feedback, :valid?
  end

  def test_feedback_with_empty_comments
    feedback = Feedback.new(name: VALID_NAME, comment: EMPTY_COMMENT)
    assert_not_predicate feedback, :valid?
  end
end
