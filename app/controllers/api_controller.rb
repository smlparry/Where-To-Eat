class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token

  def rank
    #   Location in longitude latitude as an array i.e [-37.81361110,144.96305559]
      location = params[:location]

    #   If the location was not specifed default to melborne CBD
    #   If this value is updated be sure to update the if block in Search.rank
      if location.blank?
              location = [-37.81361110,144.96305559]
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

  def test
      render  'api/rank'
  end
end
