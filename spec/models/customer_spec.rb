require 'rails_helper'

RSpec.describe Customer, type: :model do

  it { should have_many(:users).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:active) }
end