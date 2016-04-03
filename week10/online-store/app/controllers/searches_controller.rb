class SearchesController < ApplicationController
  def type_and_slug
    result = Search.by_type_and_slug(search_params)
    render json: result
  end

  def filter_by
    result = Search.by_type_and_slug(search_params)
    render json: result
  end

  private

  def search_params
    params.permit(:type, :slug, :property)
  end
end