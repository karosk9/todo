class UsersController < ApplicationController

  expose :users, -> { UserDecorator.decorate_collection(User.all) }
  expose :user, decorate: ->(user){ UserDecorator.new(user) }

  def edit
    authorize user
  end

 def update
   authorize user
   if user.update(user_params)
     redirect_to users_path
   else
     render 'edit'
   end
 end

 def destroy
   authorize user
   user.destroy
   redirect_to users_path, notice: "User #{user.full_name} was successfully deleted"
 end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
