class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, except: [:index, :show,:new, :create, :destroy]
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new

  end

  def create
  @prototype = Prototype.new(prototype_params)

  if @prototype.save
    redirect_to '/'
  else
  render :new
  end
end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)
    redirect_to prototype_path
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end
  

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

    def set_prototype
      @prototype = Prototype.find(params[:id])
    end
    
    def move_to_index
      if user_signed_in? && current_user != @prototype.user
        redirect_to action: :index
      end
  end
end
