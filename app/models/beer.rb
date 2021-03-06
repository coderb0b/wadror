class Beer < ActiveRecord::Base
include RatingAverage

	belongs_to :brewery, touch: true
  belongs_to :style, touch: true
	has_many :ratings, dependent: :destroy
	has_many :raters, -> { uniq }, through: :ratings, source: :user

	validates :name, presence: true
  validates :style, presence: true

=begin Siirretty moduuliin /lib kansioon
  def average_rating
  	ratings.average(:score)
  end
=end

  def to_s
  	"#{name} #{brewery.name}"
  end

  def self.top(n)
   sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }
   sorted_by_rating_in_desc_order.first(n)   
  end

end
