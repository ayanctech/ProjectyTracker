class TasksController < ApplicationController
  before_action :set_project

  def index
    @task=Task.all
  end
  
  def create
    @task=@project.tasks.create(task_params)
    redirect_to @project
  end

    private
    def set_project
      @project=Project.find(params[:project_id])
    end

    def task_params
      params.require(:task).permit(:name,:desc,:completed,:due_date)
    end
end
