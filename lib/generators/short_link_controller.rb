# frozen_string_literal: true

class ShortLinkController < Mints::BaseController
  skip_before_action :verify_authenticity_token

  def redirect
    code = params[:code]
    mints_link = MintsLink.new
    url = mints_link.get_url(code)
    contact_id = cookies[:mints_contact_id]
    user_agent = request.user_agent
    ip = request.remote_ip
    mints_link.visit(code, url, contact_id, user_agent, ip)
    redirect_to url
  end

  def generate
    url = params[:url]
    if url =~ /(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})/
      mints_link = MintsLink.new
      code = mints_link.generate(url)
      render json: { code: code }
    else
      render json: false
    end
  end

  def visits
    code = params[:code]
    contact_id = params[:contact_id]
    page = params[:page] ? params[:page].to_i : 1
    page_size = params[:page_size] ? params[:page_size].to_i : 1000
    filter = {}
    if code
      filter['code'] = code
    end
    if contact_id
      filter['contact_id'] = contact_id
    end
    mints_link = MintsLink.new
    visits = mints_link.get_visits(filter, page, page_size)
    render json: { data: { visits: visits } }
  end
end