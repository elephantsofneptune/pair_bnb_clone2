class UsersController < Clearance::UsersController

def new
	@user = User.new
end

def create
	@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Success!"
			redirect_to @user
		else
			flash[:error] = "Failed.."
			redirect_to :back
		end
end

def show
	@user = User.find(params[:id])
	@listings = @user.listings.paginate(page: params[:page])
end

def edit
	@user = User.find(params[:id])
end

def update
	@user = User.find(params[:id])
	byebug
	@user.update(user_params)
	redirect_to @user
end

private
	def user_params
		params.require(:user).permit(:first_name,:last_name,:email,:password, :password_confirmation, :avatar)
	end
end