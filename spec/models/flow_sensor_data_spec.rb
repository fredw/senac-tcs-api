require 'rails_helper'

RSpec.describe FlowSensorData, type: :model do
  it { should belong_to(:flow_sensor) }
  it { should validate_presence_of(:consumption_per_minute) }
end
