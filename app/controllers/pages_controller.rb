class PagesController < ApplicationController
  def index
  end

  def request_access

  end

  def mailing_list
      if params[:email].blank?
          render 'pages/request_access'
      end

      Email.create({email: params[:email], os: params[:os], name: params[:name]})
  end
end
