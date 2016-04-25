class CategoriesController < ApplicationController
  def index 
    @categories = Category.all 
  end

  def show 
  end    

  def new 
    
  end

  def create 
    @category = Category.new(category_params)
    if @category.save 
      render :show 
    else 
      flash[:notice] = "Category exists"
      render :error 
    end 
  end

  def category_params 
    params.require(:category).permit(:name, :description)
  end 
end
