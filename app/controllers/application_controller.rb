class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def show
    @name = 'Sandip'
  end
end
