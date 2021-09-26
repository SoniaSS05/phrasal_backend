class Meaning < ApplicationRecord
  belongs_to :phrasal
  has_many :meanbodies
end
