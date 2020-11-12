class WorksController < ApplicationController
  def homepage
    @works = Work.all

    @albums = @works.where(category: 'album')
    # @sample_albums = @albums.sample(10)

    @books = @works.where(category: 'book')
    @movies = @works.where(category: 'movie')
  end

  def index
    @works = Work.all

    @albums = @works.where(category: 'album')
    @books = @works.where(category: 'book')
    @movies = @works.where(category: 'movie')

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

  def show
    id = params[:id]
    @work = Work.find_by(id: id)

    if @work.nil?
      redirect_to works_path and return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path and return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path and return
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work) and return
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work
      @work.destroy
      redirect_to root_path and return
    else #if destroy fails
      redirect_to works_path and return
    end

  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication, :description)
  end
end
