 class CommentsController < ApplicationController
    before_action :authenticate_user!

    def new
      @post = Post.find(params[:post_id])
      @comment = Comment.new
    end

    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)
      @comment.user_id = current_user.id

      if @comment.save
        flash[:success] = "Comment has been saved!"
        redirect_to posts_path
      else
        flash[:alert] = "Sorry, unable to save your comment!"
      end
    end

    private

    def comment_params
      params[:comment].permit(:content)
    end

end
