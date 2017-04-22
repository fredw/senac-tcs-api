require 'rails_helper'

RSpec.describe FlowSensor, type: :model do
  it { should belong_to(:device) }
  it { should validate_presence_of(:pin) }
  it { should validate_length_of(:pin).is_equal_to(2) }
end
