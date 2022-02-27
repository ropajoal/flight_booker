class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @flight = Flight.find(params[:flight_id])
    n_passengers = params[:passengers].to_i
    n_passengers.times { @booking.passengers.build }
    @price = (@flight.price * n_passengers).to_f.round(2)
  end

  def create
    @booking = Booking.new(params_booking)
    if @booking.save
      flight = Flight.find(params[:booking][:flight_id])
      flight.seats_left -= params[:booking][:passengers_attributes].keys.length
      flight.save!
      @booking.passengers.each{ |passenger| PassengerMailer.with(passenger: passenger).confirmation_email.deliver_now! }
      redirect_to action: "show", id: @booking.id
    else
      puts booking.errors.full_messages
      render :new
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private
    def params_booking
      params.require(:booking).permit(:flight_id, passengers_attributes:[:name, :email])
    end
end
