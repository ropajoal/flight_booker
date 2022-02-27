class PassengerMailer < ApplicationMailer
  default from: 'notifications@example.com'
  def confirmation_email
	puts params
	@passenger = params[:passenger]
    @url = "https://localhost:3000/passenger/#{@passenger.id}" 
    mail(to:@passenger.email, subject: "Confirmation email for flight##{@passenger.booking.flight.id} booking")
  end
end
