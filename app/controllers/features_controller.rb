class FeaturesController < ApplicationController
  before_action :set_project

  def index
    @features=Feature.all
  end

  def new
    @feature=Feature.new
    @feature.tasks.new
  end

  def edit
    @feature=@project.features.find(params[:feature_id])
  end

  def create
    @feature=@project.features.new(feature_params)
    if @feature.save
      send_mail_notify(0,@feature,feature_params[:name],feature_params[:category])
      if feature_params[:tasks_attributes].to_h.length !=0
        start=feature_params[:tasks_attributes].keys[0]
        uid=feature_params[:tasks_attributes][start][:user_id]
        #AdminMailer.send_mail(User.find(uid).name).deliver_later
        send_email(User.find(uid).name)
      end
      redirect_to @project, flash: { success: "Feature created Successfully!" }
    else
      redirect_to @project, flash: { danger: "Feature Creation Failed!!" }
    end
  end

  def update
    @feature=Feature.find(params[:id])

    l=feature_params[:tasks_attributes].to_h.length
    if l>0
      start=feature_params[:tasks_attributes]

      start.each do |f|
        fet=f[1]
        if fet.key?("id")
          t=Task.find(fet[:id])
          tp=Task.new(fet)

          if t.user_id != tp.user_id || t.name != tp.name || t.completed != tp.completed
            send_mail_notify(1, @feature, feature_params[:name], feature_params[:category])

            send_email(User.find(fet[:user_id]).name)
          end
        else
          send_mail_notify(1, @feature, feature_params[:name], feature_params[:category])

          send_email(User.find(fet[:user_id]).name)
        end
      end
    end

    if @feature.update_attributes(feature_params)

      redirect_to @project, flash: { success: "Feature Updated Successfully!" }
    else
      redirect_to @project, flash: { danger: "Feature Updatation Failed!!" }
    end
  end

  def destroy
    @feature=Feature.find(params[:id])
    @feature.destroy
    redirect_to project_path(@project)
  end

  private
  def set_project
    @project=Project.find(params[:project_id])
  end


  def send_email(uname)
    AdminMailer.send_mail(uname).deliver_later
  end

  def feature_params
    params.require(:feature).permit(:name, :desc, :category, :file, :status, :feature_token_id, notifications_attributes: [:notify_name], tasks_attributes: [:name,:completed, :user_id, :id])
  end

end
