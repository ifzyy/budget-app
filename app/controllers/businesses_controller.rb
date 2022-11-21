class BusinessesController < ApplicationController
  def new
    @category = Category.includes(:category_businesses).find(params[:category_id])
    @business = @category.businesses.new
    @categories = current_user
  end

  def create
    @category = Category.find(params[:category_id])
    if @category.user != current_user
      flash[:alert] = 'You can only create transaction from your categories'
      redirect_to categories_path
    end
    if business_params[:category_ids].length == 1
      flash[:alert] = 'Must select at least one category'
      redirect_to new_category_business_path(@category)
    else
      @category = Category.find(params[:category_id])
      @business = Business.new(business_params)
      @business.author = current_user

      if @business.save
        flash[:notice] = 'Transaction was created successfully'
        redirect_to @category
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @category = Category.includes(:category_businesses).find(params[:category_id])
    @business = @category.businesses.includes(:category_businesses).find(params[:id])
    @category_businesses = CategoryBusiness.where(category_id: @category.id, business_id: @business.id)
    if @business.destroy
      flash[:success] = 'Transaction was successfully deleted.'
      redirect_to category_path(@category.id)
    else
      flash[:error] = 'Something went wrong'
      render :show
    end
  end

  def business_params
    params.require(:business).permit(:name, :amount, category_ids: [])
  end
end
