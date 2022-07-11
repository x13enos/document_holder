class Api::V1::DocumentsController < Api::V1::BaseController

  def index
    @documents = current_user.documents.search(params).order(created_at: :desc)
    render 'index', formats: :json
  end

  def create
    @document = current_user.documents.new(document_params)
    @document.images.attach(params[:images])
    if @document.save
      render partial: 'api/v1/documents/document', formats: :json, locals: { document: @document }
    else
      render json: { errors: @document.errors }, status: 400
    end
  end

  def update
    @document = current_user.documents.find(params[:id])
    @document.attributes = document_params
    if @document.valid?
      @document.images.attach(params[:images])
      handle_images
      @document.save
      render partial: 'api/v1/documents/document', formats: :json, locals: { document: @document.reload }
    else
      render json: { errors: @document.errors }, status: 400
    end
  end

  def destroy
    document = current_user.documents.find(params[:id])
    if document.destroy
      render json: { status: :ok }, formats: :json
    else
      render json: { errors: document.errors }, status: 400
    end
  end

  private

  def document_params
    params.permit(:name, :box_id)
  end

  def handle_images
    if params[:deleted_images].present?
      @document.images.to_a.select { |i| params[:deleted_images].include?(i.id.to_s) }.each do |image|
        image.purge
      end
    end
  end
end