class InsertMenuController < ApplicationController
  def restaurant
      if ! params[:restaurant].blank?
            Restaurant.create(name: params[:restaurant], address: "This address", open_hours: "these open hours", rating: 100, uri: "this")
      end
  end

  def category
      if ! params[:restaurant_id].blank?
          @default = params[:restaurant_id]
          Category.create(restaurant_id: params[:restaurant_id], category: params[:category])
      else
          @default = 1
      end
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

  def insert_database

    # cast sql file to string
      sqlString = <<-EOS
      INSERT INTO restaurants VALUES (1878, 'Dumpling King', 'Shop E4 Southern Cross Lane Melbourne', 'M T W T F S S   Breakfast          Lunch               Dinner          Late', '2015-03-03 10:43:44.973926', '2015-03-03 10:43:44.973926', 53, '/r/71/1574078/restaurant/CBD/Dumpling-King-Melbourne', -37.6222197, 144.9356767);
      INSERT INTO restaurants VALUES (1879, 'Dumpling World', '608 Collins St, Melbourne VIC 3000', 'M T W T F S S   Breakfast          Lunch                 Dinner                 Late', '2015-03-03 10:43:44.976930', '2015-03-03 10:43:44.976930', 54, '/r/71/1675732/restaurant/CBD/Dumpling-World-Melbourne', -37.8188483, 144.9546975);
      INSERT INTO restaurants VALUES (1880, 'In a Rush Espresso', 'The Atrium Federation Sq Melbourne', 'M T W T F S S   Breakfast                 Lunch                 Dinner          Late', '2015-03-03 10:43:44.980307', '2015-03-03 10:43:44.980307', 38, '/r/71/1727175/restaurant/CBD/In-a-Rush-Espresso-Melbourne', -37.8174865, 144.9676356);
      INSERT INTO restaurants VALUES (1881, 'Michel''s Patisserie', '300 Lonsdale St. Melbourne', 'Monday - Thursday 6:30am-6:30pm Friday 6:30am-8:30pm Saturday - Sunday 8:00am-6:00pm', '2015-03-03 10:43:45.006715', '2015-03-03 10:43:45.006715', 19, '/r/71/1604240/restaurant/CBD/Michels-Patisserie-Melbourne', -37.8117955, 144.9637178);

      EOS

    #   Each sql query
      s = sqlString.split(';')

      # loop and insert
      s.each do |sql|
          ActiveRecord::Base.connection.execute(sql)
      end


  end
end
