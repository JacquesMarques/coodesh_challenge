class ErrorMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def error_email
    @message = params[:message]
    mail(to: ENV.fetch('ERROR_EMAIL'), subject: 'Erro no Scraping do Open Foods Fact')
  end
end
