class BeermappingApi
	def self.places_in(city)
		city = city.downcase
		Rails.cache.fetch(city, expires_in: 168.hours) { fetch_places_in(city)}
	end

	def self.place_in(id, city)
		city = city.downcase		
		places_in(city).select{ |p| p.id==id }.first
		#places_in(city).select{ |p| p.id==id } palauttaa arrayn.
		#Arrayn .first palauttaa ensimmäisen alkion
	end

	private
	

	def self.fetch_places_in(city)
		api_key = self.key
		url = "http://beermapping.com/webservice/loccity/#{api_key}/"
		response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"

		places = response.parsed_response["bmp_locations"]["location"]

		return [] if places.is_a?(Hash) and places['id'].nil?

		places = [places] if places.is_a?(Hash)
		places.map do | place |
			Place.new(place)
		end
	end

	def self.key
		raise "APIKEY not defined" if ENV['APIKEY'].nil?
		ENV['APIKEY']
	end
end
