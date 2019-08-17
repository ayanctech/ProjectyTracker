class ProjectsController < ApplicationController
  before_action :login_required
  before_action :set_project, only: [:edit, :update, :destroy, :show]

  def index
    @projects = Project.all.order('created_at DESC')
    @project = Project.new
  end

  def new
    @project = Project.new

  end

  def show
    @feature=@project.features.build
    @feature.feature_id=auto_generate_id
    @comment=@project.comments.build
    
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

    if @project.update(params[:project].permit(:title, :body))
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
    params.require(:project).permit(:title, :description, :features_attributes => [:name], :comments_attributes => [:content, :commenter_name] ,:tasks_attributes => [:name])
  end
  def auto_generate_id
    SecureRandom.random_number(1_000_000)
  end
end
