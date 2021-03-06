require 'rails_helper'

RSpec.describe LevelSensor, type: :model do
  it { should belong_to(:ruler) }
  it { should have_many(:level_sensors_data).dependent(:destroy) }
  it { should validate_presence_of(:pin) }
  it { should validate_presence_of(:volume) }
  it { should validate_length_of(:pin).is_at_most(2) }

  context 'when pin already exists' do
    let(:device) { create(:device) }
    let(:ruler1) { create(:ruler, device: device) }
    let(:ruler2) { create(:ruler, device: device) }
    let(:level_sensor) do
      create(:level_sensor, ruler: ruler1, pin: 'A1')
      build(:level_sensor, ruler: ruler2, pin: 'A1')
    end

    it 'should be invalid' do
      expect(level_sensor).to be_invalid
      expect(level_sensor.errors[:pin].size).to eq(1)
    end
  end
end
