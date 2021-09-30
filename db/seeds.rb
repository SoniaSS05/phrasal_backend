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

Phrasal.delete_all
Verb.delete_all
Prepadv.delete_all


somephrasalverbs = ['get%20across', 'get%20ahead', 'get%20over', 'get%20at',
                    'come%20across',  'come%20on', 'come%20back', 'come%20before',
                    'take%20out', 'take%20off', 'take%20up', 'take%20over',
                    'keep%20down', 'keep%20away', 'keep%20on', 'keep%20back',
                    'call%20up', 'call%20off', 'call%20forth', 'call%20away']

someprepadv = []
verbarray = []
verbuniq = []
prepadvarray = []
verbasocprep = []

#Split verbs and prepositions/adv in different arrays
19.times do |i|
    verbprep =  somephrasalverbs[i].split('%20')
    verbarray[i] = verbprep[0]
    prepadvarray[i] = verbprep[1]
end


prepadvattribute = ["name"]
verbfilt = verbarray.uniq

verbfilt.length.times do |i|
    url = "https://api.dictionaryapi.dev/api/v2/entries/en/" + somephrasalverbs[i] #API with definition of Phrasal Verb
    response = RestClient::Request.execute(method: :get, url: url)
    result = JSON.parse response.to_str #Answer API

    wholeasoc = somephrasalverbs.select{ |elem| elem.include?(verbfilt[i])} #Take all word that include 'get', e.g.
    j = 0
    wholeasoc.length.times do |j|
        onlyprep = wholeasoc[j].split('%20') #Split preposition/adverb from wholeasoc
        verbasocprep[j] = onlyprep[1]  #Grab whole preposition that 'get' has, e.g.
    end
    verb = Verb.create!(name: verbfilt[i])
    verbasocprep.length.times do |k|
        hash = Hash.new
        hash['name'] = verbasocprep[k]
        prepadv = Prepadv.find_or_create_by!(hash)
        verb.prepadvs << prepadv
        
        lookverb = "verb_id = " + verb.id.to_s
        lookprepadv = "prepadv_id = "+ prepadv.id.to_s
        phrasal_id_obj = Phrasal.where(lookverb && lookprepadv)
        phrasal_id = phrasal_id_obj[0].id
        if((result[0]['meanings'][0]['definitions'].length >= 3))
            defmean0 = result[0]['meanings'][0]['definitions'][0]['definition']
            meaning1 = Meaning.create!(definition: defmean0,  phrasal_id: phrasal_id) 

            defmean1 = result[0]['meanings'][0]['definitions'][1]['definition']
            meaning2 = Meaning.create!(definition: defmean1,  phrasal_id: phrasal_id) 
 
            defmean2 = result[0]['meanings'][0]['definitions'][2]['definition']
            meaning3 = Meaning.create!(definition: defmean2, phrasal_id: phrasal_id) 
          
           
             
        else if ((result[0]['meanings'][0]['definitions'].length >= 2))

            defmean0 = result[0]['meanings'][0]['definitions'][0]['definition']
            meaning1 = Meaning.create!(definition: defmean0,  phrasal_id: phrasal_id) 
          
            defmean1 = result[0]['meanings'][0]['definitions'][1]['definition']
            meaning2 = Meaning.create!(definition: defmean1,  phrasal_id: phrasal_id) 

        
            else
                defmean0 = result[0]['meanings'][0]['definitions'][0]['definition']
                meaning1 = Meaning.create!(definition: defmean0,  phrasal_id: phrasal_id) 
             
        
            end
    
            
        end 
    
    end   
  
    
end




