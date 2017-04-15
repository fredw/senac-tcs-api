class ReservoirGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservoir_group, only: [:show, :update, :destroy]

  # GET /reservoir_groups
  def index
    @reservoir_groups = policy_scope(ReservoirGroup.all)
    authorize ReservoirGroup
    render json: @reservoir_groups
  end

  # GET /reservoir_groups/1
  def show
    render json: @reservoir_group
  end

  # POST /reservoir_groups
  def create
    @reservoir_group = ReservoirGroup.new(reservoir_group_params)
    authorize @reservoir_group
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
      authorize @reservoir_group
    end

    # Only allow a trusted parameter "white list" through.
    def reservoir_group_params
      params.require(:reservoir_group).permit(:name, :customer_id)
    end
end
