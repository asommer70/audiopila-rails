class AudiosController < ApplicationController
  before_action :set_audio, only: [:show, :edit, :update, :destroy]

  # GET /audios
  # GET /audios.json
  def index
    @audios = Audio.all
    @repositories = Settings.repositories
    @manuals = Audio.where("path ~ ?", 'http')
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

    # Remove Audio if no longer in repo.
    Audio.where("path ~ ?", repo).each do |audio|
      unless File.exists?(audio.path)
        audio.destroy
      end
    end

    flash[:info] = 'Repository sync successful.'
    redirect_to audios_path
  end

  def stream
    audio = Audio.find(params[:id])

    begin
      unless audio.path.index('http')
        response.headers['Content-Type'] = "audio/#{audio.name[-3..-1]}"
        response.headers['Content-Length'] = File.size(audio.path).to_s
        response.headers['Accept-Ranges'] = 'bytes'
        response.headers['Cache-Control'] = 'no-cache'

        send_file audio.path
      end
    rescue
      flash[:alert] = 'Audio file not found in this location: ' + audio.path
      render json: { status: 'Not Found' }
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
      params[:audio].permit(:name, :path, :playback_time, :album_id, :album_order)
    end
end
