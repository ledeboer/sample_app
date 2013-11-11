class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in user
      redirect_back_or user
    else
      # Create an error message and re-render the signin form.
      if user
        flash.now[:error] = 'Invalid email/password combination' 
      else
        flash.now[:error] = 'Invalid sign in attempt: That email is not a registered user'
      end
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
