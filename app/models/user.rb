class User < ActiveRecord::Base
include RatingAverage
    validates :username, uniqueness: true,
                         length: { minimum: 3 }
    validates :username, length: { maximum: 15 }
    validates :password, length: { minimum: 4 } 
    validates :password, format: { with:/(?=.*[A-Z])/ }    

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings

	has_many :memberships, dependent: :destroy
	has_many :beerclubs, through: :memberships

	has_secure_password



  def self.top(n)     
   

   #i=0
   #num=n
   #top_raters=[]

   #while i<num do
    top_raters = User.all.group_by{|u| u.ratings.count}.sort.reverse.map{|x,y| y}.take(3)
    #i+=1     
    
   #end
   #return top_raters
   #User.all.group_by{|u| u.ratings.count}.sort.reverse
   #User.all.group_by{|u| u.ratings.count}.sort.reverse.map{|x,y| y}
   #User.all.map { |u| u.ratings.count }
   #User.includes(:ratings).group_by{|u| u.ratings.count}


  end

	def favorite_beer
		return nil if ratings.empty?
		#ratings.order(score: :desc).limit(1).first.beer
    ratings.sort_by{ |r| r.score }.last.beer
	end

	def favorite_style
    return nil if ratings.empty?

    rated = ratings.map{ |r| r.beer.style }.uniq
    rated.sort_by { |style| -rating_of_style(style) }.first
  end

  def favorite_brewery
    return nil if ratings.empty?

    rated = ratings.map{ |r| r.beer.brewery }.uniq
    rated.sort_by { |brewery| -rating_of_brewery(brewery) }.first
  end

  private

  def rating_of_style(style)
    ratings_of = ratings.select{ |r| r.beer.style==style }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end

  def rating_of_brewery(brewery)
    ratings_of = ratings.select{ |r| r.beer.brewery==brewery }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end

end
