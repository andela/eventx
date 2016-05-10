class CategoriesController < ApplicationController
  def index
    @categories = Category.current
  end

  def show
  end

  def new
  end

  def create
    @category = Category.new(category_params)
    @category.manager_profile_id = current_user.manager_profile.id
    if @category.save
      render :show
    end
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
