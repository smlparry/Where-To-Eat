Rails.configuration.stripe = {
  :publishable_key => "pk_live_35FUw1MUMZZIAyV2gHHK5ntr",
  :secret_key      => "sk_live_IlQoZshQbHTMRd7QsU6yGpLA"
  ]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
