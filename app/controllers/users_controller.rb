class UsersController < ApplicationController
  include AuthHelper
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search]
      @user=User.search(params[:search]).sort
    else
      @user=User.all
    end
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      #session[:user_id] = @user.id
      AdminMailer.registration_confirmation(@user).deliver
      redirect_to users_path, flash: { success: "User Created Successfully! PLease confirm your email to login" }
    else
      render "new", flash: { danger: "User Creation Failed!!" }
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user), flash: { success: "User Updated Successfully!" }
    else
      render "edit", flash: { danger: "User updation error!!" }
    end

  end

  def show
  end

  def edit
  end

  def destroy
    @user.destroy
    redirect_to users_path, flash: { info: "User Deleted Successfully!" }
  end

  def confirm_email
    user=User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      session[:user_id] = user.id
      redirect_to user_path(user), flash: { success: "Kudos! You are welcome !" }
    else
      redirect_to users_path, flash: { danger: "Sorry, the intended user does not exist" }
    end
  end

  private
  def set_user
    @user=User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :search)
  end


end
