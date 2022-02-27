class PassengersController < ApplicationController
  def confirm_email
    passenger = Passenger.find(params[:id])
    passenger.email_confirmed = true
    passenger.save
    redirect_to "/bookings/#{passenger.booking.id}"
  end
end
