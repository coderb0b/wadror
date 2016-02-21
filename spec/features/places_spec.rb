require 'rails_helper'

describe "places" do
	it "if one is returned by the API, it is shown at the page" do
		#Korvataan API:n käyttö stub-komponentilla
		allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
			[ Place.new( name:"Oljenkorsi", id: 1 ) ]
		)

		visit places_path
		fill_in('city', with: 'kumpula')
		click_button "Search"

		expect(page).to have_content "Oljenkorsi"
	end

	it "if multiple returned by the API, all are shown at the page" do
		allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
			[ Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"räkälä", id: 2 ) ]
		)

		visit places_path
		fill_in('city', with: 'kumpula')
		click_button "Search"

		expect(page).to have_content "Oljenkorsi"
		expect(page).to have_content "räkälä"
	end

	it "if empty returned by the API, show correct message" do
		allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return([])
		@city = 'kumpula'

		visit places_path
		fill_in('city', with: @city)
		click_button "Search"
		
		expect(page).to have_content "No bars in #{@city}"
	end


end
