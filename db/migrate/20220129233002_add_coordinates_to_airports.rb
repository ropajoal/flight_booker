class AddCoordinatesToAirports < ActiveRecord::Migration[6.1]
  def change
    add_column :airports, :longitude, :decimal
    add_column :airports, :latitude, :decimal
  end
end
