require 'rails_helper'

RSpec.describe ReservoirGroup, type: :model do
  it { should belong_to(:customer) }
  it { should have_many(:reservoirs).dependent(:nullify) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(100) }
end
