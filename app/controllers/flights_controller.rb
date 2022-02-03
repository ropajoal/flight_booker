class FlightsController < ApplicationController
  def index
    @airport_codes = Airport.all.to_a.map{|airport| [airport.code,airport.id]}
    @airport_codes.unshift(["Code","0"])
    @passengers = Array.new(5).map.with_index{|v,i| i}
    @dates = Flight.all.to_a.map{ |flight| flight.start_datetime }.sort.map{ |date| date.strftime("%d/%m/%Y") }.uniq
    @dates.unshift("Date")
    where_str = ""
    if params[:from_airport]
      where_str += " departure_airport_id = " + params[:from_airport]
    end
    if params[:to_airport]
      where_str += " AND " unless where_str == ""
      where_str += " arrival_airport_id = "+ params[:to_airport]
    end
    if params[:passengers]
      where_str += " AND " unless where_str == ""
      where_str += " seats_left >= " + params[:passengers]
    end
    if params[:date]
      where_str += " AND " unless where_str == ""
      date = DateTime.strptime(params[:date],'%d/%m/%Y')
      next_date = date + 1.day
      where_str += " start_datetime BETWEEN '" + date.strftime('%Y-%m-%d 00:00:00') + "' AND '"+next_date.strftime('%Y-%m-%d 00:00:00')+"'"
    end
    puts where_str
    unless where_str == ""
      @flights = Flight.includes(:departure_airport, :arrival_airport).where(where_str)
    end
  end
end
