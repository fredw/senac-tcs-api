require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class.new(user, record) }

  let(:record) { create(:user) }

  context 'with an admin user' do
    let(:user) { create(:user_admin) }
    it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
  end

  context 'without an admin user' do
    let(:user) { create(:user) }
    it { is_expected.to forbid_actions([:index, :create, :update, :destroy]) }

    describe 'when user wants to see the data of others users' do
      let(:record) { create(:user) }
      it { is_expected.to forbid_action(:show) }
    end

    describe 'when user wants to see their own data' do
      let(:record) { user }
      it { is_expected.to permit_action(:show) }
    end
  end
end
