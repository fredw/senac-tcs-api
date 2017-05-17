require 'rails_helper'

RSpec.describe RulerDataPolicy do
  subject { described_class.new(user, ruler_data) }

  let(:ruler_data) { create(:ruler_data) }

  context 'with an admin user' do
    let(:user) { create(:user_admin) }
    it { is_expected.to permit_actions([:index, :show, :create]) }
    it { is_expected.to forbid_actions([:update, :destroy]) }
  end

  context 'without an admin user' do
    let(:user) { create(:user) }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to forbid_actions([:update, :destroy]) }

    describe 'when customer is different' do
      let(:ruler_data) { create(:ruler_data, ruler: create(:ruler, device: create(:device, reservoir: create(:reservoir, customer: create(:customer))))) }
      let(:user) { create(:user, customer: create(:customer)) }
      it { is_expected.to forbid_actions([:show, :create]) }
    end

    describe 'when customer is equal' do
      it { is_expected.to permit_actions([:show, :create]) }
    end
  end
end
