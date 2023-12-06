#if you are using the API key
ActionMailer::Base.smtp_settings = {
    domain: 'localhost',
    address: "smtp.sendgrid.net",
    port: 587,
    authentication: :plain,
    user_name: 'apikey',
    password: Rails.application.credentials.sendgrid_key
}