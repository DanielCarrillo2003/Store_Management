class SalesMailer < ApplicationMailer
  def send_receipt(user_name, user_email, products_hash, total_to_pay)
    @name = user_name
    @products_hash = products_hash
    @total = total_to_pay
    mail to: user_email, subject: 'Detalles de tu compra'
  end
end
