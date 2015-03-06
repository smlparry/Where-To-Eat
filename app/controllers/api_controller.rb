class ApiController < ApplicationController
  def rank
      location = [-37.81361110, 144.96305559]
      price = 1000

      if price.blank? or location.blank?
          respond_to do |format|
              format.json { render :json => Respond.no_input }
          end
      else
          respond_to do |format|
              if Search.rank(price, location).blank?
                 format.json { render :json => Respond.no_results }
              else
                  format.json { render :json => Search.rank(price, location) }
              end
          end
      end
  end
end
