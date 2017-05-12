require 'rails_helper'

RSpec.describe LevelSensorData, type: :model do
  it { should belong_to(:level_sensor) }
  it { should belong_to(:ruler_data) }
end
