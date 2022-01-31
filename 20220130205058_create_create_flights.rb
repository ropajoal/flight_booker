class CreateFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :flights do |t|
      t.references :departure_airport, null: false, foreign_key: { to_table: :airports }, on_delete: :cascade
      t.references :arrival_airport, null: false, foreign_key: { to_table: :airports }, on_delete: :cascade
      t.datetime :start_datetime, null: false
      t.time :duration
      t.integer :seats_left, null: false

      t.decimal :flights, :price, :decimal, scale: 2, default: 0
      
      t.timestamps
    end
  end
end
