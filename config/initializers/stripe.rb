Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_KEY_PUB'],
  :secret_key      => ENV['STRIPE_KEY_SECRET']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
