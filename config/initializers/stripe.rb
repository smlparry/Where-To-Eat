Rails.configuration.stripe = {
  :publishable_key => "pk_test_K2kCCKRg1GJwpNQOzcEhgujG",
  :secret_key      => "sk_test_Rz5mazM5roX61QNbgDUXBbc9"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
