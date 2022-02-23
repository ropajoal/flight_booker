class CheckoutController < ApplicationController
  def create
    booking = Booking.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [
		name: "Booking Id:#{booking.id}",
		quantity: booking.passengers.length,
		amount: (booking.flight.price.to_f*100).round,
		currency: 'usd'
      ],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
    }) 
    respond_to do |format|
      format.js
    end
  end
end
