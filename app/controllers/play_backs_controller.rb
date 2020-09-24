class PlayBacksController < ApplicationController
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
    if @play_back.save && send_m3u8
      redirect_to @play_back, notice: "#{t(:play_back)} #{t(:created)}."
    else
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
    redirect_to play_backs_url, notice: "#{t(:play_back)} #{t(:destroyed)}."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_play_back
    @play_back = PlayBack.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def play_back_params
    params.require(:play_back).permit(:title, :url, :views, :video)
  end

  def send_m3u8
    require 'm3u8'
    require 'tempfile'
    require 'fileutils'

    absolute_path = request.original_url
    video_path = File.join 'uploads', 'play_back', 'video', @play_back.id.to_s
    path = File.join Rails.root, 'public', 'uploads', 'play_back', 'video', @play_back.id.to_s
    FileUtils.mkdir_p(path) unless File.exist?(path) 

    @playlist = M3u8::Playlist.new

    name = @play_back.video_url.to_s.split('/').pop

    unless (File.exist?("#{path}/#{name}"))
      #move between folders due heroku breaks
      FileUtils.mv("#{Rails.root}/public#{@play_back.video_url.to_s}", "#{path}/#{name}")
    end
    unless (File.exist?("#{path}/#{name}.ts"))
      #disabled due heroku build pack ffmpeg not implemented in this app yet
      system("ffmpeg -i #{path}/#{name} -c:v libx264 -c:a aac -b:a 160k -bsf:v h264_mp4toannexb -f mpegts -crf 32 #{path}/#{name}.ts ");
    end

    @options = { version: 1, cache: false, target: 12, sequence: 1 }
    @playlist = M3u8::Playlist.new(@options)
    @item = M3u8::SegmentItem.new(duration: 11, segment: "#{request.base_url}/#{video_path}/#{name}")
    @playlist.items << @item
    playlist = M3u8::Playlist.read(@playlist.to_s)

    File.write("#{path}/video.mp4.m3u8", "#EXTM3U\n#{playlist.items.first}")
    @play_back.update(url: "#{request.base_url}/#{video_path}/video.mp4.m3u8")
  end
end
