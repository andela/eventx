class WelcomeController < ApplicationController

  def index
  end
  def set
    session[:url] = events_new_path
  end
end
