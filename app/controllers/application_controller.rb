class ApplicationController < ActionController::Base
  helper_method :check_owner

  def check_owner
    redirect_to play_backs_path,
    alert: t(:oops_401).capitalize if @play_back.user.id != current_user.id
  end
end
