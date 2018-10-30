class Api::UsersController < ApplicationController
  def index
    if current_user
      @users = current_user.users
      render "index.json.jbuilder"
    else
      render json: []
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render 'show.json.jbuilder'
  end

  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )

    if user.save
      render json: {message: 'User created successfully'}, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end
  end
end
