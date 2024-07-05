class DocumentsController < ApplicationController
  before_action :authenticate_user!, except: [:shared]
  before_action :set_document, only: [:show, :edit, :update, :destroy, :share]

  def index
    @documents = policy_scope(Document)
  end

  def show
    authorize @document
  end

  def new
    @document = current_user.documents.new
    authorize @document
  end

  def create
    @document = current_user.documents.new(document_params)
    authorize @document

    if @document.save
      redirect_to @document, notice: 'Document was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @document
  end

  def update
    authorize @document
    if @document.update(document_params)
      redirect_to @document, notice: 'Document was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @document
    @document.destroy
    redirect_to documents_url, notice: 'Document was successfully destroyed.'
  end

  def share
    authorize @document
    @share_url = document_share_url(@document.share_token)
  end

  def shared
    @document = Document.find_by!(share_token: params[:share_token])
    render :show
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:name, :file)
  end
end