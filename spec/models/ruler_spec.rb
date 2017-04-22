require 'rails_helper'

RSpec.describe Ruler, type: :model do
  it { should belong_to(:device) }
  it { should validate_presence_of(:height) }
end
