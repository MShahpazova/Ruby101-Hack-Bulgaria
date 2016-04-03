  class ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products
  end
  
  def create
    product = Product.new(product_params)
    if product.save
      render json: product
    else
      render json: product.errors
    end
  end
  
  def count
    render json: Product.all.count
  end
  
  def show
    render json: Product.find(params[:id])
  end
  
  def count_range
    render json: Product.where("id > ?", params[:id]).limit(params[:count])
  end

  def range
    render json: Product.where("id > ?", params[:id])
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      render json: product
    else
      render json: product.errors
    end  
  end

  def destroy
     product = Product.find(params[:id])
     product.destroy
     if product.destroyed?
        render json: {"destroyed" => "successful"} 
      else  
        render json: product.errors
     end  
  end
  
  private

  def product_params
    params.require(:product).permit(:name, :category_id)
  end
  
n
  <<-json
    {"name": "asdasd", "category_id": 2}
  json
end