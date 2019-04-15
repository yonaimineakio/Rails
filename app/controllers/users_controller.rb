class UsersController < ApplicationController
  #logged_in_userはこのファイルに書いたメソッド名
 before_action :logged_in_user, only: [:edit, :update, :index, :destroy]

 before_action :correct_user, only: [:edit, :update]

 before_action :admin_user, only: :destroy


  def index

    @users=User.paginate(page: params[:page], per_page: 30)

  end

  def new

    @user = User.new

  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_url(@user)

    else
      render "new"
    end
  end

  def edit
  end

  def update
   if @user.update_attributes(user_params)
     flash[:success]= "Profile updated"
     redirect_to @user

     #更新に成功した場合を扱う
   else
    render 'edit'
   end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success]="User deleted"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end

#ログイン済みユーザーかどうかを確認

def logged_in_user

  unless logged_in?
    store_location
    flash[:danger]="Please log in."
    redirect_to login_url

  end
end

 def correct_user
   @user=User.find(params[:id])
   redirect_to(root_url) unless current_user?(@user)
 end

 def admin_user
   redirect_to(root_url) unless current_user.admin?
 end


end
