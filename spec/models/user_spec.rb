require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
  	user = User.new username:"Pekka"

  	#user.username.should == "Pekka"
  	expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
  	user = User.create username:"Pekka"

  	#expect(user.valid?).to eq(false)
  	expect(user).not_to be_valid
  	expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    #let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }
    #let suorittaa olion alustuksen vasta kun olio tarvitaan oikeasti
    #FactoryGirl käyttöön:
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      #rating = Rating.new score:10
      #rating2 = Rating.new score:20
      
      #user.ratings << rating
      #user.ratings << rating2

      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)
    	
    	expect(user.ratings.count).to eq(2)
    	expect(user.average_rating).to eq(15.0)
    end

   end



end



   RSpec.describe User, type: :model do
   	it "has password with over 3 characters" do
   		user = User.create username:"Olli", password:"abc", password_confirmation:"abc"

   		expect(user).not_to be_valid
   		expect(User.count).to eq(0)
   	end
   end


   RSpec.describe User, type: :model do
   	it "password, not only characters" do
   		user = User.create username:"Olli", password:"abcaaa", password_confirmation:"abcaaa"

   		expect(user).not_to be_valid
   		expect(User.count).to eq(0)
   	end

    describe "favorite beer" do
      let(:user){FactoryGirl.create(:user)}

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating =FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      #beer1 = FactoryGirl.create(:beer)
      #beer2 = FactoryGirl.create(:beer)
      #beer3 = FactoryGirl.create(:beer)
      #rating1 = FactoryGirl.create(:rating, beer:beer1, user:user)
      #rating2 = FactoryGirl.create(:rating, score:25,  beer:beer2, user:user)
      #rating3 = FactoryGirl.create(:rating, score:9, beer:beer3, user:user)
      
      create_beer_with_rating(user, 10)
      best = create_beer_with_rating(user, 25)
      create_beer_with_rating(user, 7)

      expect(user.favorite_beer).to eq(best)
    end
  end

end #describe user



     #apumetodi oluiden luontiin joilla reittauksia
   def create_beer_with_rating(user, score)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def create_beers_with_ratings(user, *scores)
    scores.each do |score|
      create_beer_with_rating(user, score)
    end
  end



