class AdminMailer < ApplicationMailer
    def products_expiring_notification(products, admin_emails)
        @products = products
        mail(to: admin_emails, subject: 'Productos a expirar esta semana')
    end
end
