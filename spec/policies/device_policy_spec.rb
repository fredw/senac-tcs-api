require 'rails_helper'

RSpec.describe DevicePolicy do
  subject { described_class.new(user, device) }

  let(:device) { create(:device) }

  context 'with an admin user' do
    let(:user) { create(:user_admin) }
    it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy, :generate]) }
  end

  context 'without an admin user' do
    let(:user) { create(:user) }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to forbid_actions([:create, :update, :destroy]) }

    describe 'when customer is different' do
      let(:device) { create(:device, reservoir: create(:reservoir, customer: create(:customer))) }
      let(:user) { create(:user, customer: create(:customer)) }
      it { is_expected.to forbid_actions([:show, :generate]) }
    end

    describe 'when customer is equal' do
      it { is_expected.to permit_actions([:show, :generate]) }
    end
  end
end
