require 'rails_helper'

RSpec.describe Device, type: :model do
  it { should belong_to(:reservoir) }
  it { should have_many(:flow_sensors).dependent(:destroy) }
  it { should have_many(:rulers).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(100) }
  it { should validate_length_of(:description).is_at_most(250) }
end
