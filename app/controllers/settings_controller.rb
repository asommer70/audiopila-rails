class SettingsController < ApplicationController

  def index
    @repositories = Settings.repositories
  end

  def create
    if Settings.repositories
      Settings.repositories = Settings.repositories << settings_params[:repositories][0]
    else
      Settings.repositories = settings_params[:repositories]
    end

    respond_to do |format|
      @repositories = Settings.repositories

      flash[:success] = 'Setting successfully saved.'
      format.html { redirect_to settings_path, success: 'Setting was successfully saved.' }
      format.json { render :index, status: :created, location: settings_path }
    end
  end

  def destroy
    if params[:id] == 'repositories'
      Settings.repositories.delete_at(params[:index].to_i)
      Settings.repositories = Settings.repositories
    end

    Settings.save
    @repositories = Settings.repositories

    respond_to do |format|
      flash[:success] = 'Setting successfully deleted.'
      format.html { redirect_to settings_path, success: 'Setting was successfully deleted.' }
      format.json { render :index, status: :created, location: settings_path }
    end
  end

  private
    def settings_params
      params.require(:settings).permit(repositories: [])
    end
end
