class ListingsController < ApplicationController
  before_action :require_login
  
  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
  end
  
  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: "Successfully listed!" }
      else
        format.html { redirect_to new_listing_path, notice: "Failed" }
        format.js
      end
    end    
  end

  def edit
    @listing = Listing.find(params[:id])  
  end

  def update
    @listing = Listing.find(params[:id])
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: "Listing updated!" }
      else
        format.html { redirect_to edit_listing_path, notice: "Failed to update" }
        format.js
      end
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    flash[:success] = "Deleted listing"
    redirect_to root_path
  end

  private
  def listing_params
    params.require(:listing).permit(:title,:address,:pax,:user_id)
  end

end
