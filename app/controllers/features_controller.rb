class FeaturesController < ApplicationController
  before_action :set_project

  def index
    @features=Feature.all
  end

  def new
  end
  
  def create
    @feature=@project.features.create(feature_params)
    redirect_to @project
  end

    private
    def set_project
      @project=Project.find(params[:project_id])
    end

    def feature_params
      params.require(:feature).permit(:name,:desc)
    end
end
