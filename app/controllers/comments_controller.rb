class CommentsController < ApplicationController

  before_action :correct_user


  def index

    @comments=@micropost.comments.paginate(page: params[:page], per_page: 30)


  end

  def create
    @comment=@micropost.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to micropost_comments_path
    else
      redirect_to request.referrer || root_url
    end
  end

  def destroy
    @comment = @micropost.comments.find(params[:id])
    @comment.destroy
    flash[:success]="Comment deleted!"
    redirect_to request.referrer || root_path
  end

  def correct_user
    @micropost=Micropost.find(params[:micropost_id])
    redirect_to root_url if @micropost.nil?
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :image)
  end

end
