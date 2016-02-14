require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is created, if beer has name and style" do
  	beer = Beer.create name:"testi", style:"aijaa"

    expect(beer).to be_valid
end
  it "is not created without a name" do
  	beer = Beer.create name:"", style:"aijaa"

  	expect(beer).not_to be_valid
  end
  it "is not created without a style" do
    beer = Beer.create name:"hölkynkökyn", style:"" 
    
    expect(beer).not_to be_valid
end
end
