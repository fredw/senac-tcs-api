class ReservoirGroupsController < ApplicationController
  before_action :set_reservoir_group, only: [:show, :update, :destroy]

  # GET /reservoir_groups
  def index
    @reservoir_groups = ReservoirGroup.all
    render json: @reservoir_groups
  end

  # GET /reservoir_groups/1
  def show
    render json: @reservoir_group
  end

  # POST /reservoir_groups
  def create
    @reservoir_group = ReservoirGroup.new(reservoir_group_params)
    if @reservoir_group.save
      render json: @reservoir_group, status: :created, location: @reservoir_group
    else
      render json: @reservoir_group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservoir_groups/1
  def update
    if @reservoir_group.update(reservoir_group_params)
      render json: @reservoir_group
    else
      render json: @reservoir_group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservoir_groups/1
  def destroy
    @reservoir_group.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservoir_group
      @reservoir_group = ReservoirGroup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reservoir_group_params
      params.require(:reservoir_group).permit(:name)
    end
end
