class UsersController < ApplicationController
  #logged_in_userはこのファイルに書いたメソッド名
 before_action :logged_in_user, only: [:edit, :update, :index, :destroy, :following, :followers]

 before_action :correct_user, only: [:edit, :update]

 before_action :admin_user, only: :destroy


  def index

    @users=User.where(activated: true).paginate(page: params[:page], per_page: 30)

  end

  def new

    @user = User.new

  end

  def show


    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
    redirect_to root_url and return unless @user.activated?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
     UserMailer.account_activation(@user).deliver_now
     flash[:info] = "Please check your email to activate your account."
     redirect_to root_url
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


 def following
   @title="Following"
   @user=User.find(params[:id])
   @users=@user.following.paginate(page: params[:page])
   render 'show_follow'
 end

 def followers
  @title="Followers"
  @user = User.find(params[:id])
  @users = @user.followers.paginate(page: params[:page])
  render 'show_follow'
 end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end





 def correct_user
   @user=User.find(params[:id])
   redirect_to(root_url) unless current_user?(@user)
 end

 def admin_user
   redirect_to(root_url) unless current_user.admin?
 end

 def message_room_id(first_user, second_user)
  first_id = first_user.id.to_i
  second_id = second_user.id.to_i
  if first_id < second_id
    "#{first_user.id}-#{second_user.id}"
  else
    "#{second_user.id}-#{first_user.id}"
  end
end


end
