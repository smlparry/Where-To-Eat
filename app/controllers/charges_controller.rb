class ChargesController < ApplicationController
    def new
    end
    def create
        begin
        # Amount in cents
          @amount = (params[:charge_amount].to_i * 0.01).floor
          plan = @amount.to_s + '_plan'
          description = "Name: " + params[:contact_name] + ", Restaurant: " + params[:restaurant_name] + ", Restaurant ID: " + params[:restaurant_id]

          customer = Stripe::Customer.create(
            :email => params[:stripeEmail],
            :source => params[:stripeToken],
            :plan => plan,
            :description => description
          )

          Restaurant.where(id: params[:restaurant_id]).update_all(active: true)

        rescue Stripe::CardError => e
          flash[:error] = e.message
          redirect_to charges_path
        end
    end

    def show
    end

    def delete
    end
end
