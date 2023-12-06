class SalesMailer < ApplicationMailer
  def send_receipt(user_name, user_email)
    @name = user_name
    mail to: user_email, subject: 'Hola desde sales_maler.rb'
  end
end
