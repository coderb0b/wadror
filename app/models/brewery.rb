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

    scope :active, -> { where active:true }
    scope :retired, -> { where active:[nil, false] }

  def self.top(n)
   sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
   sorted_by_rating_in_desc_order.first(n)
   # palauta listalta parhaat n kappaletta
   # miten? ks. http://www.ruby-doc.org/core-2.1.0/Array.html
  end



=begin Siirretty moduliin /lib kansioon
	def average_rating
		ratings.average(:score)
	end
=end

end
