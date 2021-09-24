class Admin::GenresController < ApplicationController

  before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.all

  end

 def edit
   @genre = Genre.find(params[:id])

 end

 def create
     @genre = Genre.new(genre_params)
     if
         @genre.save
         redirect_to admin_genres_path
     else
         redirect_to
     end
 end

 def update
   genre = Genre.find(params[:id])
    if genre.update(genre_params)
      redirect_to admin_genres_path
    else
      flash[:genre_updated_error] = "ジャンル名を入力してください"
      redirect_to edit_admin_genre_path(genre)
    end

 end

 def show
     @item = Ttem.find([:id])
 end

private
 def genre_params
     params.require(:genre).permit(:name)
 end

end