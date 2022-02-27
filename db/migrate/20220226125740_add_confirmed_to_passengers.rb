class AddConfirmedToPassengers < ActiveRecord::Migration[6.1]
  def change
    add_column :passengers, :email_confirmed, :boolean, default: false
  end
end
