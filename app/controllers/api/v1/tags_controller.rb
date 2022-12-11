class Api::V1::TagsController < Api::V1::BaseController

  def index
    @tags = current_user.tags.order(created_at: :desc)
    render 'index', formats: :json
  end

  def create
    @tag = current_user.tags.new(tag_params)
    if @tag.save
      render partial: 'api/v1/tags/item', formats: :json, locals: { tag: @tag }
    else
      render json: { errors: @tag.errors }, status: 400
    end
  end

  def update
    @tag = current_user.tags.find(params[:id])
    if @tag.update(tag_params)
      render partial: 'api/v1/tags/item', formats: :json, locals: { tag: @tag }
    else
      render json: { errors: @tag.errors }, status: 400
    end
  end

  def destroy
    @tag = current_user.tags.find(params[:id])
    if @tag.destroy
      render json: { status: :ok }, formats: :json
    else
      render json: { errors: @tag.errors }, status: 400
    end
  end

  private

  def tag_params
    params.permit(:name, :color)
  end
end