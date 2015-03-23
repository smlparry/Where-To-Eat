Rails.configuration.stripe = {
  :publishable_key => "pk_test_y8ch8eh6c2Jvgv1sjrn8ELFT",
  :secret_key      => "sk_test_PDUOaztkWIpJkxpFLrrOhv2c"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
