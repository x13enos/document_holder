class Api::V1::DocumentsController < Api::V1::BaseController

  def index
    @documents = current_user.documents.order(created_at: :desc)
    render 'index', formats: :json
  end

  def create
    @document = current_user.documents.new(document_params)
    if @document.save
      render partial: 'api/v1/documents/document', formats: :json, locals: { document: @document }
    else
      render json: { errors: @document.errors }, status: 400
    end
  end

  private

  def document_params
    params.permit(:name, images: [])
  end
end