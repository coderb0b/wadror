class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :beerclub

  def to_s
    "#{beerclub.name}"
  end

end
