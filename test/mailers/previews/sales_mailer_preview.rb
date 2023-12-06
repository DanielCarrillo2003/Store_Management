# Preview all emails at http://localhost:3000/rails/mailers/sales_mailer
class SalesMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/sales_mailer/send_receipt
  def send_receipt
    SalesMailer.send_receipt
  end

end
