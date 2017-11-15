class CategoriesController < ApplicationController
	def index
		@categories = Category.all
		if request.xhr?
			render json: { html: render_to_string("partials/_categories_render", layout: false) }
		end
	end


  def new
   @category = Category.new
  end

  def create
    new_category = Category.create(name: params[:category][:name], user_id: session[:user_id])
    Cloudinary::Uploader.upload(params[:category][:img_src], :public_id => "#{session[:user_id]}-#{new_category.id}-Category")
    new_category.img_src = "#{session[:user_id]}-#{new_category.id}-Category"
    new_category.save
    redirect_to root_path
  end

  def destroy
    @category = Category.find_by(name: params[:data], user_id: session[:user_id])
    @category.destroy
  end


end
