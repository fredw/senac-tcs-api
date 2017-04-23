require 'rails_helper'

RSpec.describe LevelSensor, type: :model do
  it { should belong_to(:ruler) }
  it { should validate_presence_of(:pin) }
  it { should validate_presence_of(:volume) }
  it { should validate_presence_of(:sequence) }
  it { should validate_length_of(:pin).is_equal_to(2) }
  it { should validate_uniqueness_of(:sequence).scoped_to(:ruler_id) }
end
