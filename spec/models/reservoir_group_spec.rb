require 'rails_helper'

RSpec.describe ReservoirGroup, type: :model do
  it { should has_many(:reservoir) }
  it { should has_many(:customer) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(100) }
end
