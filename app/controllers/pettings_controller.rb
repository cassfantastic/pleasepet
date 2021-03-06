class PettingsController < ApplicationController
  before_action :set_petting, only: [:show, :edit, :update, :destroy]

  # GET /pettings
  # GET /pettings.json
  def index
    @pettings = Petting.where("petter_id=? OR petted_id=?", current_pet.id, current_pet.id)
    @petters = Petting.where("petted_id=?", current_pet.id).group(:petter_id).order('count_id desc').count('id')
    @petted = Petting.where("petter_id=?", current_pet.id).group(:petted_id).order('count_id desc').count('id')
  end

  # GET /pettings/1
  # GET /pettings/1.json
  def show; end

  # GET /pettings/new
  def new
    @petting = Petting.new
  end

  # GET /pettings/1/edit
  def edit; end

  # PATCH/PUT /pettings/1
  # PATCH/PUT /pettings/1.json
  def update
    respond_to do |format|
      if @petting.update(petting_params)
        format.html { redirect_to @petting, notice: 'Petting was successfully updated.' }
        format.json { render :show, status: :ok, location: @petting }
      else
        format.html { render :edit }
        format.json { render json: @petting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pettings/1
  # DELETE /pettings/1.json
  def destroy
    @petting.destroy
    respond_to do |format|
      format.html { redirect_to pettings_url, notice: 'Petting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_petting
    @petting = Petting.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def petting_params
    params.require(:petting).permit(:petter_id, :petted_id, :petted_at)
  end
end
