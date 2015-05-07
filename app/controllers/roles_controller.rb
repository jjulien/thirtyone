class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  after_action :authorize_role

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  # GET /role/1
  # GET /role/1.json
  def show
    @role = Role.find(params[:id])
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)
    aRPrm = params[:PermGrp]
    iPmssn = 0
    if aRPrm == nil
      respond_to do |format|
        flash[:notice] = " <<< Please Enter a name and select at least one checkbox. >>> "
        format.html {render action: 'new' }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end

    else
      # iTgl = 1
      # iROprm = 0
      # iRWprm = 0
      # aRPrm.each { |p|
      #   if iTgl == 1
      #     iTgl = 2
      #     iROprm = p.to_i
      #     iPmssn+=p.to_i
      #   else
      #     iTgl = 1
      #     iRWprm = p.to_i
      #     iPmssn+=p.to_i
      #   end
      #
      #   iROWttl = iROprm + iRWprm
      #   if iROWttl == 3 or iROWttl == 12 or iROWttl == 48 or iROWttl == 192 or iROWttl == 768 or iROWttl == 3072
      #     iPmssn-=iROprm
      #   end
      # }
      aRPrm.each { |p| iPmssn+=p.to_i }
      # aRPrm = iPmssn

      respond_to do |format|
        # success = @role.save
        # format.html { success ? (redirect_to @role, notice: 'Role was successfully created.') : (render action: 'new') }

        # @role.name = params['role']['name']
        # @role.permissions = aRPrm
        @role.permissions = iPmssn

        if @role.save
          format.html { redirect_to @role, notice: 'Role was successfully created.' }
          format.json { render action: 'show', status: :created, location: @role }
        else
          format.html { render action: 'new' }
          format.json { render json: @role.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    aRPrm = params[:PermGrp]
    iPmssn = 0
    aRPrm.each { |p| iPmssn+=p.to_i }

    respond_to do |format|
      @role.permissions = iPmssn

      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
  def role_params
    params.require(:role).permit(:PrmGrp, :name, :permissions)
  end

  def authorize_role
    authorize :role
  end
end
