require 'rails_helper'

RSpec.describe Ruler, type: :model do
  it { should belong_to(:device) }
  it { should have_many(:level_sensors).dependent(:destroy) }
  it { should validate_presence_of(:height) }
end
