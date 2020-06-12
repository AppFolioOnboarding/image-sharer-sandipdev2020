require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  def test_create_valid_feedback
    assert_difference 'Feedback.count', 1 do
      post api_feedbacks_path, params: {
        feedback: {
          name: 'foo',
          comment: 'bar'
        }
      }
    end

    assert_response :created

    body = JSON.parse(response.body)
    assert_equal 'Successfully saved!', body['message']
  end

  def test_create_invalid_feedback
    assert_no_difference 'Feedback.count' do
      post api_feedbacks_path, params: {
        feedback: {
          name: 'foo',
          comment: ''
        }
      }
    end

    assert_response :internal_server_error

    body = JSON.parse(response.body)
    assert_equal 'Could not save feedback!', body['message']
    assert_empty flash
  end
end
