class UsersController < ApplicationController

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(username: params[:user][:username])

    if user.nil?
      # new user
      user = User.new(username: params[:user][:username])
      if user.save
        flash[:success] = "Successfully created new user #{user.username} with ID: #{user.id}"
      else
        render :new, status: :bad_request and return
        #should this have an else statement for if the save fails?  Validation fails?
      end
    else
      # existing user
      flash[:success] = "Successfully logged in as existing user #{user.username}"
    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:success] = 'Successfully logged out'
      else
        session[:user_id] = nil
        flash[:notice] = 'ERROR unknown user'
      end
    else
      flash[:error] = 'You must be logged in to log out'
      redirect_to root_path
      return
    end

    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])

    unless @current_user
      flash[:error] = "A problem occurred: You must log in to do that"
      return
      #do I need to redirect?  sample site does not when you try to vote w/o being logged in
    end
  end

end
