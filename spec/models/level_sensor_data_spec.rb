require 'rails_helper'

RSpec.describe LevelSensorData, type: :model do
  it { should belong_to(:level_sensor) }
end
