class PlayBacksController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :set_play_back, only: %i[show edit update destroy]

  # GET /play_backs
  # GET /play_backs.json
  def index
    @play_backs = PlayBack.all
  end

  # GET /play_backs/1
  # GET /play_backs/1.json
  def show
  end

  # GET /play_backs/new
  def new
    @play_back = PlayBack.new
  end

  # GET /play_backs/1/edit
  def edit
  end

  # POST /play_backs
  # POST /play_backs.json
  def create
    @play_back = PlayBack.new(play_back_params)
    if try_saving
      redirect_to @play_back, notice: "#{t(:play_back)} #{t(:created)}."
    else
      flash.now[:alert] = t(:oops_error)
      render :new
    end
  end

  # PATCH/PUT /play_backs/1
  # PATCH/PUT /play_backs/1.json
  def update
    if @play_back.update(play_back_params)
      redirect_to @play_back, notice: "#{t(:play_back)} #{t(:updated)}."
    else
      render :edit
    end
  end

  # DELETE /play_backs/1
  # DELETE /play_backs/1.json
  def destroy
    @play_back.destroy
    erase_data
    redirect_to play_backs_url, notice: "#{t(:play_back)} #{t(:destroyed)}."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_play_back
    @play_back = PlayBack.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def play_back_params
    params.require(:play_back)
          .permit(:title, :video)
          .merge(url: exist_play_back ? @play_back.url : 'link',
                 views: exist_play_back ? @play_back.views : 0)
  end
  # rubocop:disable all
  def generate_m3u8
    require 'm3u8'
    require 'tempfile'
    require 'fileutils'

    absolute_path = request.original_url
    video_path = File.join 'uploads', 'play_back', 'video', @play_back.id.to_s
    path = File.join Rails.root, 'public', 'uploads', 'play_back',
                                 'video', @play_back.id.to_s
    FileUtils.mkdir_p(path) unless File.exist?(path)

    @address = @play_back.video_url.to_s.split('/')
    name = @address.pop

    in_= "#{path}/#{name}"
    out_ = "#{in_}.m3u8"
    ffmpeg = "ffmpeg -i #{in_} -hls_time 20 -hls_flags single_file #{out_}"

    unless (File.exist?(in_))
      FileUtils.mv("#{Rails.root}/public#{@play_back.video_url.to_s}", in_)
    end
    unless (File.exist?("#{in_}.m3u8"))
      system(ffmpeg)
    end
    
    master_playlist = M3u8::Playlist.new
    options = { level: 4.1, audio_codec: 'aac-lc', bandwidth: 540,
                uri: "#{request.base_url}/#{video_path}/#{name}.m3u8" }
    item = M3u8::PlaylistItem.new(options)
    master_playlist.items << item
    File.write("#{path}/master_#{name}.m3u8", "#{master_playlist.to_s}")

    new_url = "#{request.base_url}/#{video_path}/master_#{name}.m3u8"
    @play_back.update(url: new_url)
  end
  # rubocop:enable all

  def try_saving
    !params[:play_back][:video].nil? && @play_back.save && generate_m3u8
  end

  def exist_play_back
    !@play_back.nil? && @play_back.persisted?
  end

  def erase_data
    require 'fileutils'

    prefix = request.base_url
    suffix = @play_back.url.split('/').pop
    dir = @play_back.url.delete_suffix(suffix)
    dir = dir.delete_prefix(prefix)
    FileUtils.rm_rf("public#{dir}")
  end
end
