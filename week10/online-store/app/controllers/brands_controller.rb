class BrandsController < ApplicationController
  def index 
    brands = Brand.all
    render json: brands
  end

  def create
    brand = Brand.new(brand_params)
    if brand.save
      render json: brand
    else
      render json: brand.errors
    end
  end
  
  def update
    brand = Brand.find(params[:id])
    if brand.update(brand_params)  
      render json: brand
    else
      render json: brand.errors
    end
  end

  def count
   count = Brand.all.count
   render json: count 
  end
  
  def destroy 
   brand = Brand.find(params[:id])
   brand.destroy
   if brand.destroyed?
    render json: {"destroyed"=>"successful"}
   else
    render json: brand.errors 
   end  
  end

  def count_range
    render json: Brand.where("id > ?", params[:id]).limit(params[:count])
  end
  
  def range
    render json: Brand.where("id >= ?", params[:id])  
  end

  private

  def brand_params
    params.permit(:name, :content)
  end

end