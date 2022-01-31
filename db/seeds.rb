require 'json'
require 'open-uri'

def distance(loc1, loc2)
  rad_per_deg = Math::PI/180  # PI / 180
  rkm = 6371                  # Earth radius in kilometers
  rm = rkm * 1000             # Radius in meters

  dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
  dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

  lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
  lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

  a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
  c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

  rm * c  # Delta in meters
end


Flight.delete_all
Airport.delete_all
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'airports'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'flights'")

airport_records = (JSON.parse URI.open('https://gist.github.com/tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588/airports.json').read).map { |airport| {code: airport["code"], name: airport["name"], longitude: airport["lon"], latitude: airport["lat"]} }
random_airport_records= []
20.times { random_airport_records.push airport_records.sample }
random_airport_records.sort_by! { |airport_record| airport_record[:code] }
random_airport_records.map! { |airport_record| airport_record.merge ( { created_at: Time.now, updated_at: Time.now } ) }
Airport.insert_all random_airport_records

airportList = Airport.all.to_a
flightsInfo = []
until airportList.empty?
  airportOne = airportList.shift
  airportList.each do |airportTwo|
    distanceMiles = distance([airportOne.latitude,airportOne.longitude],[airportTwo.latitude,airportTwo.longitude]) * 0.000621371
    duration = distanceMiles / 520
    price = distanceMiles * 0.016
    flightsInfo.push ({ departure_airport_id: airportOne.id, arrival_airport_id: airportTwo.id, start_datetime: rand(1.month).seconds.from_now.beginning_of_minute, duration: duration, price: price, seats_left: 50, created_at: Time.now, updated_at: Time.now })

    flightsInfo.push ({ departure_airport_id: airportTwo.id, arrival_airport_id: airportOne.id, start_datetime: rand(1.month).seconds.from_now.beginning_of_minute, duration: duration, price: price, seats_left: 50, created_at: Time.now, updated_at: Time.now })
  end
end

Flight.insert_all flightsInfo



