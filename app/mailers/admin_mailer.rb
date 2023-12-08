class AdminMailer < ApplicationMailer
    def products_expiring_notification(products, admin_emails)
        puts "Sending email to #{admin_emails}" # Add this line for debugging
        @products = products
        mail(to: admin_emails, subject: 'Productos a expirar esta semana')
    end
end
