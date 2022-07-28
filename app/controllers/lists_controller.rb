class ListsController < ApplicationController
  before_action :set_list, only: %i[show destroy edit update]

  def index
    @lists = List.all
  end

  def show
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    movie = Movie.find(params[:movie_id])
    @list.movies = movie
    raise
    if @list.save
      redirect_to lists_path, status: :see_other
    end
  end

  def edit
  end

  def update
    @list.update(list_params)
    if @list.save
      redirect_to lists_path
    else
      redirect_to edit_list_path(@list), status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
