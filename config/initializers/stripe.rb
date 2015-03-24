Rails.configuration.stripe = {
  :publishable_key => ENV["STRIPE_LIVE_PUB"],
  :secret_key      => ENV["STRIPE_LIVE_SECRET"]
  ]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
