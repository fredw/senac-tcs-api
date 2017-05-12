class RulerData < ApplicationRecord
  belongs_to :ruler
  has_many :level_sensor_data, dependent: :destroy

  accepts_nested_attributes_for :level_sensor_data, allow_destroy: true

  validates :ruler, presence: true
  validate :verify_all_sensors

  scope :from_customer, -> (customer) { joins(ruler: [{device: :reservoir}]).where(reservoirs: { customer_id: customer.id }) }
  scope :by_date, -> (from, to) { where('created_at >= ? AND created_at <= ?', from, to) }

  private

  def verify_all_sensors
    if ruler && LevelSensor.where(ruler_id: ruler.id).size != level_sensor_data.size
      errors.add(:level_sensor_data, 'It\'s necessary to inform all sensors of this ruler')
    end
  end
end
