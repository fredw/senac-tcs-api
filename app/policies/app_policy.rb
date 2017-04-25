class AppPolicy < Struct.new(:user, :app)

  def index?
    customer_active?
  end

  def show?
    customer_active?
  end

  def create?
    customer_active?
  end

  def new?
    customer_active?
  end

  def update?
    customer_active?
  end

  def edit?
    customer_active?
  end

  def destroy?
    customer_active?
  end

  private

  def customer_active?
    user.customer.active?
  end
end
