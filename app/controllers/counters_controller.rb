class CountersController < ApplicationController
  protect_from_forgery except: [:count]
  def count
    @video_id = counter_params[:v_id]
    @video_view = counter_params[:view]
    update_video_views
  end

  def update_video_views
    @play_back = PlayBack.find(@video_id)
    @views_old = @play_back.views

    render status: :ok, json: { message: 'all fine' }.to_json if update_views
  end

  def counter_params
    params.require(:counter).permit(:v_id, :view)
  end

  def update_views
    @play_back.update(views: (@views_old + 1)) && @video_view
  end
end
