class Api::V1::BoxesController < Api::V1::BaseController

  def index
    @boxes = current_user.boxes.order(created_at: :desc)
    render 'index', formats: :json
  end

  def create
    @box = current_user.boxes.new(box_params)
    if @box.save
      render partial: 'api/v1/boxes/item', formats: :json, locals: { box: @box }
    else
      render json: { errors: @box.errors }, status: 400
    end
  end

  def update
    @box = current_user.boxes.find(params[:id])
    if @box.update(box_params)
      render partial: 'api/v1/boxes/item', formats: :json, locals: { box: @box }
    else
      render json: { errors: @box.errors }, status: 400
    end
  end

  def destroy
    @box = current_user.boxes.find(params[:id])
    if @box.delete
      render json: { status: :ok }, formats: :json
    else
      render json: { errors: @box.errors }, status: 400
    end
  end

  private

  def box_params
    params.permit(:name, :color)
  end
end