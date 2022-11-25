class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user

    if @category.save
      flash[:success] = 'Category successfully created'
      redirect_to categories_path
    else
      flash[:danger] = 'Something went wrong'
      render 'new'
    end
  end

  def show
    @category = Category.includes(:businesses).find(params[:id])
    @transactions = @category.businesses.order(created_at: :desc)
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:success] = 'category was successfully deleted.'
      redirect_to categories_path
    else
      flash[:error] = 'Something went wrong'
      render :show
    end
  end
end
