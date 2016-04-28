class CategoriesController < ApplicationController
  def index
    @categories = Category.where(
      "manager_profile_id = ? OR manager_profile_id = ?",
      0, ActsAsTenant.current_tenant.id)
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
    else
      flash[:notice] = "Category exists"
      render :error
    end
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
