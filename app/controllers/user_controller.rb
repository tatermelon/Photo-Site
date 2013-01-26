class UserController < ApplicationController
  
  def login 
    @user = User.new
  end
  
  def logout
    session[:user] = nil
    redirect_to(:action => :login);
  end
  
  def post_login
    loginName = params[:user][:login]
    @user = User.find_by_login(loginName.downcase())
    if @user
      if @user.password_valid?(params[:user][:password])
        session[:user] = @user.id
        redirect_to(:controller => :pics, :action => :user, :id => @user.id)
        return
      else 
        flash[:alert] = "Invalid Password"
      end
    else 
      flash[:alert] = "Invalid Username"
    end
    redirect_to(:action => :login)
  end
  
  def register
    @user = User.new
  end
  
  def edit
  end
  
  def post_register
    @user = User.new(params[:user])
    @user.save
    if @user.valid?
      session[:user] = @user.id
      redirect_to(:controller => :pics, :action => :user, :id => @user.id)
    else
      render(:action => :edit)
    end
  end
  
end