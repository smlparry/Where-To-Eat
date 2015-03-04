class InsertMenuController < ApplicationController
  def category
      if ! params[:restaurant_id].blank?
          @default = params[:restaurant_id]
          Category.create(restaurant_id: params[:restaurant_id], category: params[:category])
      else
          @default = 1
      end
  end

  def restaurant
  end

  def items
    if ! params[:category_id].blank?
        @category_default = params[:category_id]
        @restaurant_default = params[:restaurant_id]
        @inaccuracy = params[:inaccuracy]
        if ! (params[:item].blank? or params[:price].blank?)
            Item.create(restaurant_id: params[:restaurant_id], category_id: params[:category_id], item: params[:item], price: params[:price], inaccuracy: params[:inaccuracy])
        else
            @item_default = params[:item]
            @price_default = params[:price]
        end
    else
        @category_default = 1
        @restaurant_default = 1
    end
  end
end
