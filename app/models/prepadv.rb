class Prepadv < ApplicationRecord
    has_many :phrasals
    has_many:verbs, through: :phrasals
end
