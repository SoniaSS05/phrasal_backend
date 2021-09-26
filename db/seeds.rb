# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#To communicate with API 
require 'json'
require 'rest-client'

somephrasalverbs = ['get%20around', 'get%20after', 'get%20across', 'get%20ahead', 'get%20over',
                    'come%20across', 'come%20apart', 'come%20on', 'come%20back', 'come%20apart',
                    'take%20out', 'take%20off', 'take%20aside', 'take%20in', 'take%20over',
                    'keep%20around', 'keep%20down', 'keep%20away', 'keep%20on', 'keep%20back',
                    'call%20back', 'call%20up', 'call%20off', 'call%20for', 'call%20away']

                    