class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: ['PENDING', 'APPROVED', 'DENIED'] }
  validate :overlapping_approved_requests

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat,
    dependent: :destroy


  def approve!
    self.transaction do
      unless overlapping_approved_requests
        self.status = 'APPROVED'
      else
        deny!
      end
      self.save
    end
  end

  def deny!
    self.status = 'DENIED'
  end

  def overlapping_approved_requests
    # look up other request, and check to see their start_date and end_date
    # if they conflict, false, else true
    requests = CatRentalRequest.where(cat_id: self.cat_id)
    requests = requests.reject { |el| el.id == self.id  }
    self.errors[:requests] << "Overlapping approved requests" if
      requests.any? { |req| req.start_date.between?(self.start_date, self.end_date) &&
                            req.status == "APPROVED" && self.status == "APPROVED" }
  end

end
