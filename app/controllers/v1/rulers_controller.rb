module V1
  class RulersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_ruler, only: [:show, :update, :destroy]

    # GET /rulers
    def index
      @rulers = policy_scope(Ruler.where(device_id: params[:device_id]))
      authorize Ruler
      paginate json: @rulers
    end

    # GET /rulers/1
    def show
      render json: @ruler
    end

    # POST /rulers
    def create
      @ruler = Ruler.new(ruler_params)
      authorize @ruler
      if @ruler.save
        render json: @ruler, status: :created, location: @ruler
      else
        render json: @ruler.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /rulers/1
    def update
      if @ruler.update(ruler_params)
        render json: @ruler
      else
        render json: @ruler.errors, status: :unprocessable_entity
      end
    end

    # DELETE /rulers/1
    def destroy
      @ruler.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_ruler
      @ruler = Ruler.find(params[:id])
      authorize @ruler
    end

    # Only allow a trusted parameter "white list" through.
    def ruler_params
      params.require(:ruler).permit(:height, :device_id)
    end
  end
end