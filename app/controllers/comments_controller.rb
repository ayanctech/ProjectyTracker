class CommentsController < ApplicationController
  before_action :set_project

  def index
    @comments=Comment.all
  end

  def new
  end

  def create
    @comment=@project.comments.new(comment_params)
    if @comment.save
      redirect_to @project, flash: { success: "commented !" }
    else
      redirect_to @project, flash: { danger: "Comment Creation Failed!!" }
    end
  end

    private
    def set_project
      @project=Project.find(params[:project_id])
    end

    def comment_params
      params.require(:comment).permit(:content, :commenter_name)
    end
end
