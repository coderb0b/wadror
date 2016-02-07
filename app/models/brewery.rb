class Brewery < ActiveRecord::Base
include RatingAverage

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	validates :name, presence: true
	validates :year, numericality: { greater_than_or_equal_to: 1042,
	                                 only_integer: true }

    validate :current_year

  def current_year
    if year > Time.now.year
    	errors.add(:year, "ei käy")
    end
  end



=begin Siirretty moduliin /lib kansioon
	def average_rating
		ratings.average(:score)
	end
=end

end
