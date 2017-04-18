require 'rails_helper'

RSpec.describe ReservoirGroupPolicy do
  subject { described_class.new(user, reservoir_group) }

  let(:reservoir_group) { create(:reservoir_group) }

  context 'with an admin user' do
    let(:user) { create(:user_admin) }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'without an admin user' do
    let(:user) { create(:user) }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to forbid_actions([:create, :update, :destroy]) }

    describe 'when user\'s customer is different' do
      let(:reservoir_group) { create(:reservoir_group, customer: create(:customer)) }
      let(:user) { create(:user, customer: create(:customer)) }
      it { is_expected.to forbid_action(:show) }
    end

    describe 'when user\'s customer is equal' do
      it { is_expected.to permit_action(:show) }
    end
  end
end
