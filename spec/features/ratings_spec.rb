require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user, username:"testaaja" }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "show ratings and number of ratings" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button('Create Rating')

    visit new_rating_path
    select('Karhu', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button('Create Rating')

    visit ratings_path
    expect(page).to have_content "Number of ratings: 2"
    expect(page).to have_content "iso 3 15"
    expect(page).to have_content "Karhu 15"
  end

  it "check user ratings are shown correctly" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button('Create Rating')

    visit new_rating_path
    select('Karhu', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button('Create Rating')

    click_link "signout"
    sign_in(username:"testaaja", password:"Foobar1")

    visit new_rating_path
    select('Karhu', from:'rating[beer_id]')
    fill_in('rating[score]', with:'16')
    click_button('Create Rating')

    visit user_path(user2)
    expect(page).to have_content "Has made 1 rating"

  end

  it "check rating delete works correctly" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button('Create Rating')

    visit new_rating_path
    select('Karhu', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button('Create Rating')

    expect(Rating.count).to eq(2)

    find(:xpath, "//a[@href='/ratings/1']").click
    
    expect(Rating.count).to eq(1)
  end

end