require 'rails_helper'

RSpec.describe Reservoir, type: :model do
  it { should belong_to(:reservoir_group) }
  it { should belong_to(:customer) }
  it { should have_many(:devices).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:volume) }
  it { should validate_length_of(:name).is_at_most(100) }
  it { should validate_length_of(:description).is_at_most(250) }
end
