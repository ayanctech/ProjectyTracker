class ProjectsController < ApplicationController
  before_action :login_required
  before_action :set_project, only: [:edit, :update, :destroy, :show, :find_feature]

  def search_feature
    @project.features.search(params[:search])
  end

  def index
    if params[:search]
      @projects=Project.search(params[:search])
    else
      @projects = Project.all.order('created_at DESC')
    end
    @project = Project.new
  end

  def new
    @project = Project.new

  end

  def show
    @feature=@project.features.build
    @comment=@project.comments.build

    @feature.tasks.build
    @feature.notifications.build
    @comment.notifications.build

  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      redirect_to project_path(@project), flash: { success: "Project created Successfully!" }
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project),flash: { success: "Project Updated Successfully!" }
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end
  def project_params
    params.require(:project).permit(:title, :description, :search, features_attributes: [:name,tasks_attributes: [:name]], comments_attributes: [:content])
  end
  
end
