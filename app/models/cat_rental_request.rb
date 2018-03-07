# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#

class CatRentalRequest < ApplicationRecord
  validates :status, :inclusion => {in: %w(APPROVED DENIED PENDING),
    message: "APPROVED or DENIED"}
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
  validates :cat_id, presence: true
  validate :does_not_overlap_approved_request

  belongs_to :cat,
    foreign_key: :cat_id,
    class_name: :Cat

  def overlapping_requests
    CatRentalRequest.where(cat_id: self.cat_id).where(start_date: self.start_date..self.end_date)
        .where(end_date: self.start_date..self.end_date)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def does_not_overlap_approved_request
    !overlapping_approved_requests.exists?
  end


end
