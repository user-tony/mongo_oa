class Manage::HomesController < Manage::ApplicationController
  
  
  def index
    @posts = Post.active.page(params[:page])
  end
end
