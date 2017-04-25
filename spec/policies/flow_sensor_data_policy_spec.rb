require 'rails_helper'

RSpec.describe FlowSensorDataPolicy do
  subject { described_class.new(user, flow_sensor_data) }

  let(:flow_sensor_data) { create(:flow_sensor_data) }

  context 'with an admin user' do
    let(:user) { create(:user_admin) }
    it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
  end

  context 'without an admin user' do
    let(:user) { create(:user) }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to forbid_actions([:update, :destroy]) }

    describe 'when customer is different' do
      let(:flow_sensor_data) { create(:flow_sensor_data, flow_sensor: create(:flow_sensor, device: create(:device, reservoir: create(:reservoir, customer: create(:customer))))) }
      let(:user) { create(:user, customer: create(:customer)) }
      it { is_expected.to forbid_actions([:show, :create]) }
    end

    describe 'when customer is equal' do
      it { is_expected.to permit_actions([:show, :create]) }
    end
  end
end
