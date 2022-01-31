class FlightsController < ApplicationController
  def index
    @airport_codes = Airport.all.to_a.map{|airport| [airport.code,airport.id]}
	if params[:from_airport] and params[:to_airport]
		@flight = Flight.where("departure_airport_id = #{params[:from_airport]} and arrival_airport_id = #{params[:to_airport]}").limit(1)[0]
	end
  end
end
