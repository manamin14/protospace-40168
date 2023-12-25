class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes
    puts "prototypesの中身"
    puts @prototypes
  end
end
