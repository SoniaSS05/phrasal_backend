class User < ApplicationRecord
    has_many :learnedphrasals
    has_many :phrasals, through: :learnedphrasals
    has_many :successverbs
    has_many :verbs, through: :successverbs

    accepts_nested_attributes_for :successverbs
end
