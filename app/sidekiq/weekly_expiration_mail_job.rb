class WeeklyExpirationMailJob
    include Sidekiq::Worker
    sidekiq_options queue: "default"
    def perform
        puts "Job is running!"
        products_to_expire = Product.products_expiring_this_week
        admin_emails = AdminUser.pluck(:email)
        AdminMailer.products_expiring_notification(products_to_expire, admin_emails).deliver_now if products_to_expire.present?
    end
end