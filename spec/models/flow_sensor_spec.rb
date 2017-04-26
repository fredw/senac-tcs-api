require 'rails_helper'

RSpec.describe FlowSensor, type: :model do
  it { should belong_to(:device) }
  it { should have_many(:flow_sensors_data).dependent(:destroy) }
  it { should validate_presence_of(:pin) }
  it { should validate_length_of(:pin).is_at_most(2) }
  it { should validate_uniqueness_of(:pin).scoped_to(:device_id) }
end
