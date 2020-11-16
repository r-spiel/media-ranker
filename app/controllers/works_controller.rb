class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update]

  def homepage
    @top_work = Work.top_work

    @albums_top_ten = Work.top_ten('album')
    @books_top_ten = Work.top_ten('book')
    @movies_top_ten = Work.top_ten('movie')
  end

  def index
    @votes = Vote.all #try to get error message same as sample site

    @albums = Work.where(category: 'album')
    @books = Work.where(category: 'book')
    @movies = Work.where(category: 'movie')
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save #is true
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id) and return
    else
      render :new, status: :bad_request and return
    end
  end

  def show; end

  def edit; end

  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work) and return
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    if @work
      @work.destroy
      redirect_to root_path and return
    else #if destroy fails
      redirect_to works_path and return
    end
  end

  private

  def find_work
    id = params[:id]
    @work = Work.find_by(id: id)

    if @work.nil?
      redirect_to works_path and return
    end
  end


  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication, :description)
  end
end
