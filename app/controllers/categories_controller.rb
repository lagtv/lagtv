class CategoriesController < ApplicationController
  def index
    authorize! :view, Category
    @categories = Category.all_paged(params)
  end
end