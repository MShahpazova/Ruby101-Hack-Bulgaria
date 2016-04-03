class CategoriesController < ApplicationController
  def index
    categories = Category.all
    render json: categories
  end
  
  def create
    category = Category.new(category_params)
    if category.save
    render json: category
    else
    render json: category.errors   
    end
  end

  def count
    count = categories.all.count
    render json: category
  end
  
  def count_range
    render json: Category.where("id > ?", params[:id]).limit(params[:count])
  end

  def range
    render json: Category.where("id >= ?", params[:id])  
  end

  def show
    render json: Category.find(params [:id]) 
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: category, location: "/category/#{category.id}", status: :created
    else 
      render json: category.errors, status: :unprocessable_entity
    end
  end

  def update
    category = Category.find(params[:id])
   if category.update(category_params)
       render json: category
   else
     render json: category.errors 
   end  
  end
  
  def destroy
    category = Category.find(params[:id])
    category.destroy
    if category.destroyed?
        render json: {"destroyed" => "successful"}
    else
      render json: category.errors
    end  
  end

  private

  def category_params
   params.permit(:name, :brand_id)
  end
end
