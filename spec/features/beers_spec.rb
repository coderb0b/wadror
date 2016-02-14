require 'rails_helper'

include Helpers

describe "Beer" do
	before :each do
    FactoryGirl.create :user

    sign_in(username:"Pekka", password:"Foobar1")
  end
	
	it "is created when given valid name" do
		visit new_beer_path
		fill_in('beer[name]', with:"nelonen")
		
		expect{
          click_button "Create Beer"
        }.to change{Beer.count}.from(0).to(1)
	end

	it "show correct error if name not valid" do
		visit new_beer_path
		fill_in('beer[name]', with: "")
		click_button('Create Beer')
		
		expect(page).to have_content "Name can't be blank"

	end


end
