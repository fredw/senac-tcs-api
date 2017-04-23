require 'rails_helper'

RSpec.describe AppPolicy do
  subject { described_class.new(user) }

  context 'with an active customer' do
    let(:user) { create(:user) }
    it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
  end

  context 'without an active customer' do
    let(:user) { create(:user, customer: create(:customer, active: false)) }
    it { is_expected.to forbid_actions([:index, :show, :create, :update, :destroy]) }
  end
end
