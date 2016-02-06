class User < ActiveRecord::Base
include RatingAverage
    validates :username, uniqueness: true,
                         length: { minimum: 3 }
    validates :username, length: { maximum: 15 }
    validates :password, length: { minimum: 4 } 
    validates :password, format: { with:/(?=.*[A-Z])/ }

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings

	has_secure_password
end
