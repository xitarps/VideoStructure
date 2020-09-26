class PagesController < ApplicationController
  # before_action :authenticate_user!, only: %i[index]
  def index
    redirect_to play_backs_path if signed_in?
  end
end
