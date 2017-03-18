class UsersController < Clearance::UsersController

def new
	@user = User.new
end

def create
	@user = User.new(user_params)
	respond_to do |format|
		if @user.save
			format.html { redirect_to @user, notice: "Successfully registered!" }
		else
			format.html { redirect_to sign_up_path, notice: "Failed" }
			format.js
		end
	end
end

def show
	@user = User.find(params[:id])
end

def edit
	@user = User.find(params[:id])
end

def update
	@user = User.find(params[:id])
	@user.update(user_params)
	redirect_to @user
end

private
	def user_params
		params.require(:user).permit(:first_name,:last_name,:email,:password)
	end
end