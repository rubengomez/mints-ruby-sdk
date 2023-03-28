# frozen_string_literal: true

module Favorites
  ##
  # == Favorites
  # TODO: NOT CHECKED, NO DATA IN DB
  #

  def update_multiple_favorites(data)
    @client.raw('put', '/crm/favorites', nil, data)
  end

  def get_favorites(options = nil)
    @client.raw('get', '/crm/favorites', options)
  end

  def update_favorites(id, data)
    @client.raw('put', "/crm/favorites/#{id}", nil, data)
  end
end
