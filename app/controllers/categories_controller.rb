class CategoriesController < ApplicationController
  def index
    authorize! :view, Category
    @categories = Category.all_paged(params)
  end

  def new
    authorize! :create, Category
    @category = Category.new
  end

  def create
    authorize! :create, Category
    @category = Category.new(params[:category])
    
    if @category.save
      redirect_to categories_path, :notice => "Successfully created a new category!"
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
    authorize! :edit, @category
  end

  def update
    @category = Category.find(params[:id])
    authorize! :edit, @category

    if @category.update_attributes(params[:category])
       redirect_to categories_path, :notice => 'You have successfully updated the category.'
    else
      render 'edit'
    end
  end  
end