class Reservoir < ApplicationRecord
  belongs_to :customer
  belongs_to :reservoir_group, optional: true
  has_many :devices, dependent: :destroy
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 250 }
  validates :volume, presence: true

  private

  def validate_reservoir_group
    if ReservoirGroup.where(id: reservoir_group_id).empty?
      errors[:reservoir_group] << 'must exist333'
    end
  end
end
