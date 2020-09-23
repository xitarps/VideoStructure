class PlayBacksController < ApplicationController
  before_action :set_play_back, only: [:show, :edit, :update, :destroy]

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

    respond_to do |format|
      if @play_back.save
        format.html { redirect_to @play_back, notice: 'Play back was successfully created.' }
        format.json { render :show, status: :created, location: @play_back }
      else
        format.html { render :new }
        format.json { render json: @play_back.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /play_backs/1
  # PATCH/PUT /play_backs/1.json
  def update
    respond_to do |format|
      if @play_back.update(play_back_params)
        format.html { redirect_to @play_back, notice: 'Play back was successfully updated.' }
        format.json { render :show, status: :ok, location: @play_back }
      else
        format.html { render :edit }
        format.json { render json: @play_back.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /play_backs/1
  # DELETE /play_backs/1.json
  def destroy
    @play_back.destroy
    respond_to do |format|
      format.html { redirect_to play_backs_url, notice: 'Play back was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_play_back
      @play_back = PlayBack.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def play_back_params
      params.require(:play_back).permit(:title, :url, :views)
    end
end
