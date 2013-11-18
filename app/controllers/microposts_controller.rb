class MicropostsController < ApplicationController
  before_action :signed_in_user,  only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    # First apply my content filter
    @micropost.content.gsub!( /fuck/i, "frack")
    @micropost.content.gsub!( /shit/i, "poop")
    if @micropost.content.match(/.*\bcat\b.*/ix) || @micropost.content.match(/.*\bcats\b.*/ix)
    then
      flash[:fail] = "I said no cats!"
      redirect_to root_url
    else
      if @micropost.save
        flash[:success] = "Micropost created!"
        redirect_to root_url
      else
        @feed_items = []
        render 'static_pages/home'
      end
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      if @micropost.nil?
        if current_user.admin?
          @micropost = Micropost.find_by(id: params[:id]) 
        else
          redirect_to root_url
        end
      end
    end
end

