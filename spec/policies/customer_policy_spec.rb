require 'rails_helper'

RSpec.describe CustomerPolicy do
  subject { described_class.new(user, customer) }

  let(:customer) { create(:customer) }

  context 'with an admin user' do
    let(:user) { create(:user_admin) }
    it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
  end

  context 'without an admin user' do
    let(:user) { create(:user) }
    it { is_expected.to forbid_actions([:index, :show, :create, :update, :destroy]) }
  end
end
