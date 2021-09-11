class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.all

  end

 def edit
   @genre = Genre.find(params[:id])

 end

 def create
   @genre = Genre.new(genre_params)
    if  @genre.save
      redirect_to admin_genres_path
    else

      redirect_to
    end

 end

 def update

 end
 
 def show
     @item = Ttem.find([:id])
 end

 private
  def genre_params
    params.require(:@genre).permit(:name)
  end

end