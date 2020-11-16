class VotesController < ApplicationController

  def create
    user = User.find_by(id: session[:user_id])
    unless user
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_back fallback_location: '/'
      return
    end

    work = Work.find_by(id: params[:work_id])
    unless work
      flash[:error] = "A problem occurred with voting on this work."
      redirect_back fallback_location: '/'
      return
    end

    @vote = Vote.new(user_id: user.id, work_id: work.id)

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back fallback_location: '/'
    else
      flash[:error] = "A problem occurred: Could not upvote"
      # flash[:error] << @vote.errors
      redirect_back fallback_location: '/'
      return
    end

    return
  end

end
