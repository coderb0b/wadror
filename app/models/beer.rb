class Beer < ActiveRecord::Base
include RatingAverage

	belongs_to :brewery
	has_many :ratings, dependent: :destroy

=begin Siirretty moduuliin /lib kansioon
  def average_rating
  	ratings.average(:score)
  end
=end

  def to_s
  	"#{name} #{brewery.name}"
  end

end
