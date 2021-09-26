class Phrasal < ApplicationRecord
  belongs_to :verb
  belongs_to :prepadv
  has_many :meanings
  has_many :learnedphrasals
  has_many :users, through: :learnedphrasals
end
