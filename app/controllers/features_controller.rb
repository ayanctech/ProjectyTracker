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
      notification=@feature.notifications.create(notify_name: "created Feature #{feature_params[:name]} in Category #{feature_params[:category]}")
      ActionCable.server.broadcast 'notifications_channel', notification: notification.notify_name, count: Notification.all.count

      if feature_params[:tasks_attributes].to_h.length !=0
        start=feature_params[:tasks_attributes].keys[0]
        uid=feature_params[:tasks_attributes][start][:user_id]
        AdminMailer.send_mail(User.find(uid).name).deliver_later
      end
      redirect_to @project, flash: { success: "Feature created Successfully!" }
    else
      render "new"
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
            @notification=@feature.notifications.new(notify_name: "Some change to #{@feature.name}")
            AdminMailer.send_mail(User.find(fet[:user_id]).name).deliver_later
          end
        else
          @notification=@feature.notifications.new(notify_name: "change to #{@feature.name}")
          AdminMailer.send_mail(User.find(fet[:user_id]).name).deliver_later
        end
      end
    end

    if @feature.update_attributes(feature_params)
      unless @notification.nil?
        ActionCable.server.broadcast 'notifications_channel', notification: @notification.notify_name, count: Notification.all.count
      end
      redirect_to @project, flash: { success: "Feature Updated Successfully!" }
    else
      render "edit", flash: { danger: "Feature updation error!!" }
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

  def feature_params
    params.require(:feature).permit(:name, :desc, :category, :file, :status, :feature_token_id, notifications_attributes: [:notify_name], tasks_attributes: [:name,:completed, :user_id, :id])
  end
  
end
