class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authorize_user

  def create
    @user = User.new(user_params)
    if @user.save
      login!
      render partial: 'show', formats: :json, locals: { user: @user }
    else
      render json: { errors: @user.errors }, status: 400
    end
  end

  private 

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

end