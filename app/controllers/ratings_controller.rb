class RatingsController < ApplicationController
  def index
  	#@ratings = Rating.all
    #@recent_ratings = Rating.recent
    #@top_breweries = Brewery.top 3
    #@top_beers = Beer.top 3    
    #@top_raters = User.top 3
    #@top_styles = Style.top 3

    #cache optimointi, alkuperäiset kommenteissa    
    @top_beers = Rails.cache.fetch("beer top 3", expires_in: 10.minutes) { Beer.top(3) }
    @top_raters = Rails.cache.fetch("user top 3", expires_in: 10.minutes) { User.top(3) }
    @top_styles = Rails.cache.fetch("style top 3", expires_in: 10.minutes) { Style.top(3) }
    @top_breweries = Rails.cache.fetch("brewery top 3", expires_in: 10.minutes) { Brewery.top(3) }
    @recent_ratings = Rails.cache.fetch("recent ratings", expires_in: 10.minutes) { Rating.recent }
    @ratings = Rails.cache.fetch("ratings all", expires_in: 10.minutes) { Rating.all }
  	
  end  

  def new
  	@rating = Rating.new
    @beers = Beer.all
  end

  def create
  	
  	#Rating.create params[:rating]  # == Rating.create beer_id:"1", score:"24"
  	@rating = Rating.create params.require(:rating).permit(:score, :beer_id)
  	
  	#redirect_to "http://www.cs.helsinki.fi"

    # talletetaan tehdyn reittauksen sessioon
    #session[:last_rating] = "#{rating.beer.name} #{rating.score} points" 
    if @rating.save
       current_user.ratings << @rating
       redirect_to user_path current_user
    else
      @beers=Beer.all
      render :new
    end

    #redirect_to ratings_path
    

  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user==rating.user
    #redirect_to ratings_path
    redirect_to :back
  end

end