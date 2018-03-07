# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birthday    :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord
  COLORS = %w(RED BLACK WHITE BROWN GREEN YELLOW BLUE ORANGE SILVER PURPLE INDIGO GREY PINK)
  validates :name, presence: true
  validates :sex, :inclusion => {in: %w(M F),
  message: "not valid gender"}
  validates :color, :inclusion => {in: %w(RED BLACK WHITE BROWN GREEN YELLOW BLUE ORANGE SILVER PURPLE INDIGO GREY PINK),
  message: "not valid color"}

  has_many :catsrequets,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest,
    dependent: :destroy
end
