require 'rails_helper'

RSpec.describe RulerData, type: :model do
  it { should belong_to(:ruler) }
  it { should validate_presence_of(:ruler) }
end
