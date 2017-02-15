class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, presence: true
  validates :sex, length: {is: 1}
  validate :validates_sex

  has_many :cat_rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest

  def validates_sex
    self.errors[:sex] << "Invalid sex" unless self.sex.upcase == "M" || self.sex.upcase == "F"
  end

  def age
    Time.now.year - self.birth_date.year
  end


end
