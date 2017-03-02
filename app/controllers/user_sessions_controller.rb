class UserSessionsController < ApplicationController
  skip_before_action :require_login, execpt: [:destroy]

  def new
     @user = User.new
   end

   def create
     if @user = login(params[:email], params[:password])
       redirect_back_or_to('http://localhost:3000', notice: 'Login successful')
     else
       flash.now[:alert] = 'Login failed'
       render action: 'new'
     end
   end

   def destroy
     logout
     redirect_to('root_url', notice: 'Logged out!')
   end
 end
