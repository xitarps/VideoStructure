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
    if @play_back.save
      redirect_to @play_back, notice: 'Play back was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /play_backs/1
  # PATCH/PUT /play_backs/1.json
  def update
    if @play_back.update(play_back_params)
      redirect_to @play_back, notice: 'Play back was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /play_backs/1
  # DELETE /play_backs/1.json
  def destroy
    @play_back.destroy
    redirect_to play_backs_url, notice: 'Play back was successfully destroyed.'
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
end
