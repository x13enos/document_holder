class Api::V1::SessionsController < Api::V1::BaseController

  skip_before_action :authorize_user

  def create
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      login!
      render partial: 'api/v1/users/show', formats: :json,  locals: { user: current_user }
    else
      render json: { errors: ['Bad user credentials'] }, status: 401
    end
  end

  def is_logged_in
    if logged_in? && current_user
      render partial: 'api/v1/users/show', formats: :jbuilder, locals: { user: current_user }
    else
      render json: { errors: ['Unathorized user'] }, status: :forbidden
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end