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
    if ruler
      level_sensors = LevelSensor.where(ruler_id: ruler.id).order(:volume)
      # Require all sensors to be informed
      if level_sensors.size != level_sensor_data.size
        errors.add(:level_sensor_data, 'It\'s necessary to inform all sensors of this ruler')
        return
      end
      # Doesn't allow a previous sensor to be turned off and a later sensor on (considering volume order)
      any_switched_off = false
      level_sensors.each do |ls|
        level_sensor = level_sensor_data.find { |h| h.level_sensor_id == ls.id }
        if level_sensor.switched_on
          if any_switched_off && level_sensor.switched_on
            message = 'It\'s not possible to inform a turned on sensor after a turned off sensor (considering volume order)!'
            errors.add(:level_sensor_data, message)
          end
        else
          any_switched_off = true
        end
      end
    end
  end
end
