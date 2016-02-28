class PlacesController < ApplicationController
	def index
	end

	def search
		@places = BeermappingApi.places_in(params[:city])
		#tallennetaan haettu kaupunki sessioon
		session[:last_city] = params[:city]

		if @places.empty?			
			redirect_to places_path, :notice => "No bars in #{params[:city]}"
		else
			render :index			
		end		
	end

	def show
=begin	city = session[:last_city] #viimeksi haettu kaupunki
		id = params[:id] #haluttu place id
		placet_cachesta = Rails.cache.read("#{session[:last_city]}")
		#miten yksittäiseen placeen pääsee käsiksi?
=end

        @place = BeermappingApi.place_in(params[:id], session[:last_city])

	end

end