
# ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'airports'")
# require 'json'
# require 'open-uri'
# airport_records = (JSON.parse URI.open('https://gist.github.com/tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588/airports.json').read).map { |airport| {code: airport["code"], name: airport["name"], longitude: airport["lon"], latitude: airport["lat"]} }
# random_airport_records= []
# 20.times { random_airport_records.push airport_records.sample }
# random_airport_records.sort_by! { |airport_record| airport_record[:code] }
# random_airport_records.map! { |airport_record| airport_record.merge ( { created_at: Time.now, updated_at: Time.now } ) }
# Airport.insert_all random_airport_records
