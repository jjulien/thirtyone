class LocalResourcesController < ApplicationController
  before_action :set_local_resource, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_local_resource

  # GET /local_resources
  # GET /local_resources.json
  def index
    @local_resources = LocalResource.all
  end

  # GET /local_resources/1
  # GET /local_resources/1.json
  def show
  end

  # GET /local_resources/new
  def new
    @local_resource = LocalResource.new
  end

  # GET /local_resources/1/edit
  def edit
  end

  # POST /local_resources
  # POST /local_resources.json
  def create
    @local_resource = LocalResource.new(local_resource_params)

    respond_to do |format|
      if @local_resource.save
        format.html { redirect_to @local_resource, notice: 'Local resource was successfully created.' }
        format.json { render action: 'show', status: :created, location: @local_resource }
      else
        format.html { render action: 'new' }
        format.json { render json: @local_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /local_resources/1
  # PATCH/PUT /local_resources/1.json
  def update
    respond_to do |format|
      if @local_resource.update(local_resource_params)
        format.html { redirect_to @local_resource, notice: 'Local resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @local_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /local_resources/1
  # DELETE /local_resources/1.json
  def destroy
    @local_resource.destroy
    respond_to do |format|
      format.html { redirect_to local_resources_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_local_resource
      @local_resource = LocalResource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def local_resource_params
      params.require(:local_resource).permit(:contact_name, :business_name, :phone, :email, :url, :address)
    end

    def authorize_local_resource
      authorize :local_resource
    end
end
