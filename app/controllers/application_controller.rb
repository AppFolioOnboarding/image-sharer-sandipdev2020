class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def home
    @name = 'Sandip'
  end
end
