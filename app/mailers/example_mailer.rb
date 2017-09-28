class ExampleMailer < ApplicationMailer
  default from: "hectorramirezmty1990@gmail.com"

  #send the current approval rating here
  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email' )
  end
end
