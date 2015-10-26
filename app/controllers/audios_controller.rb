class AudiosController < ApplicationController
  before_action :set_audio, only: [:show, :edit, :update, :destroy]

  # GET /audios
  # GET /audios.json
  def index
    @audios = Audio.all
    @repositories = Settings.repositories
  end

  # GET /audios/1
  # GET /audios/1.json
  def show
  end

  # GET /audios/new
  def new
    @audio = Audio.new
  end

  # GET /audios/1/edit
  def edit
  end

  # POST /audios
  # POST /audios.json
  def create
    @audio = Audio.new(audio_params)

    respond_to do |format|
      if @audio.save
        format.html { redirect_to @audio, notice: 'Audio was successfully created.' }
        format.json { render :show, status: :created, location: @audio }
      else
        format.html { render :new }
        format.json { render json: @audio.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /sync_repo/:id
  def sync_repo
    repo = Settings.repositories[params[:id].to_i]

    files = `find #{repo} -name "*.mp3" -o -name "*.m4a" -o -name "*.ogg"`
    files = files.split("\n")

    files.each do |file|
      file_name = file.split('/')[-1]

      unless Audio.find_by_name(file_name)
        Audio.create(name: file_name, path: file)
      end
    end

    flash[:info] = 'Repository sync successful.'
    redirect_to audios_path
  end

  def stream
    audio = Audio.find(params[:id])
    if audio
      send_file audio.path
    end
  end

  # PATCH/PUT /audios/1
  # PATCH/PUT /audios/1.json
  def update
    respond_to do |format|
      if @audio.update(audio_params)
        format.html { redirect_to @audio, notice: 'Audio was successfully updated.' }
        format.json { render :show, status: :ok, location: @audio }
      else
        format.html { render :edit }
        format.json { render json: @audio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audios/1
  # DELETE /audios/1.json
  def destroy
    @audio.destroy
    respond_to do |format|
      format.html { redirect_to audios_url, notice: 'Audio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audio
      @audio = Audio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def audio_params
      params[:audio].permit(:name, :path)
    end
end
