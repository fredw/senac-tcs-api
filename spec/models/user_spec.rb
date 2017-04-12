require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to(:role) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_length_of(:email).is_at_most(255) }
end