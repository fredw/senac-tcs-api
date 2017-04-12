class User < ApplicationRecord

  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :timeoutable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email,
            length: { maximum: 255 },
            :uniqueness => { case_sensitive: false }
  validates :name, presence: true

  belongs_to :customer
  belongs_to :role

  before_create :set_default_role

  def admin?
    self.role.symbol == Role.symbols.fetch(:admin)
  end

  private

    def set_default_role
      self.role ||= Role.find_by_symbol(Role.symbols.fetch(:user))
    end
end
