class TasksController < ApplicationController
  before_action :set_feature

  def index
    @task=Task.all
  end

  def new
    @task=@feature.tasks.build
  end

  def create
    @task=@feature.tasks.create(task_params)
    redirect_to project
  end

    private
    def set_feature
      @feature=Feature.find(params[:feature_id])
    end

    def task_params
      params.require(:task).permit(:name,:completed,:user_id,:feature_id)
    end
end
