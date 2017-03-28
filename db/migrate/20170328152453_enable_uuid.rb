class EnableUuid < ActiveRecord::Migration[5.1]
  def change
    # Font: http://www.mccartie.com/2015/10/20/default-uuid%27s-in-rails.html
    enable_extension 'uuid-ossp'
  end
end
