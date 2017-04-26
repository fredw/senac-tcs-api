require 'rails_helper'

RSpec.describe RolePolicy do
  subject { described_class.new(user, role) }

  let(:role) { create(:role_user) }

  context 'with an admin user' do
    let(:user) { create(:user_admin) }
    it { is_expected.to permit_actions([:index, :show]) }
  end

  context 'without an admin user' do
    let(:user) { create(:user) }
    it { is_expected.to forbid_actions([:index, :show]) }
  end
end
