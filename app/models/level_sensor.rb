class LevelSensor < ApplicationRecord
  belongs_to :ruler
  has_many :level_sensors_data, dependent: :destroy

  validates :pin, presence: true, length: { maximum: 2 }
  validates :volume, presence: true
  validate :check_if_pin_already_exists

  scope :from_customer, -> (customer) do
    joins(ruler: [{device: :reservoir}]).where(reservoirs: { customer_id: customer.id })
  end

  private

  def check_if_pin_already_exists
    if pin && ruler&.device && LevelSensor.joins(:ruler).where(rulers: { device_id: self.ruler.device.id }, pin: self.pin).any?
      errors.add(:pin, 'has already been taken')
    end
  end
end
