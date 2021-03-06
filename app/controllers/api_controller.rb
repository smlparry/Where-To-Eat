class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token

  def rank
    #   Get the longitude and latitude
      lat = params[:lat]
      lng = params[:lng]


    #   If the location was not specifed default to melborne CBD
    #   If this value is updated be sure to update the if block in Search.rank
      if lat.blank?
          location = [-37.81361110,144.96305559]
      else
        #   else use the current lat and lng
          location = [lat, lng]
      end


    #   Price in cents!
      price = params[:price]

    #   Handle the response
      if price.blank?
          respond_to do |format|
              format.json { render :json => Respond.no_input }
          end
      else
          respond_to do |format|
              if Search.rank(price, location).blank?
                 format.json { render :json => Respond.no_results }
              else
                  format.json { render :json => Search.rank(price, location), :callback => params['callback'] }
              end
          end
      end
  end
end
