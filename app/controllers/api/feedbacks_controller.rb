module Api
  class FeedbacksController < ApplicationController
    def create
      feedback = Feedback.new(feedback_params)
      if feedback.save
        render status: :created, json: {message: 'Successfully saved!'}
      else
        render status: :internal_server_error, json: {message: 'Could not save feedback!'}
      end
    end

    def feedback_params
      params.require(:feedback).permit(:name, :comment)
    end
  end
end
