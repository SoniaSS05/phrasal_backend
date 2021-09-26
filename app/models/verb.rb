class Verb < ApplicationRecord
    has_many :phrasals
    has_many :prepadv, through: :phrasals
    has_many :phrases
    has_many :successverbs
    has_many :users, through: successverbs
end
