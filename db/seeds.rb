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
somephrasalverbs.length.times do |i|
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
            meaning0 = Meaning.create!(definition: defmean0,  phrasal_id: phrasal_id) 
            meanexample0 = result[0]['meanings'][0]['definitions'][0]['example']
            meansynonyms0 = result[0]['meanings'][0]['definitions'][0]['synonyms']
            meananthonyms0 = result[0]['meanings'][0]['definitions'][0]['antonyms']
            meanbody0 = Meanbody.create!(synonyms: meansynonyms0, anthonyms:meananthonyms0, 
                                        example:meanexample0, meaning_id:meaning0.id)

            defmean1 = result[0]['meanings'][0]['definitions'][1]['definition']
            meaning1 = Meaning.create!(definition: defmean1,  phrasal_id: phrasal_id) 
            meanexample1 = result[0]['meanings'][0]['definitions'][1]['example']
            meansynonyms1 = result[0]['meanings'][0]['definitions'][1]['synonyms']
            meananthonyms1 = result[0]['meanings'][0]['definitions'][1]['antonyms']
            meanbody1 = Meanbody.create!(synonyms: meansynonyms1, anthonyms:meananthonyms1, 
                                        example:meanexample1, meaning_id:meaning1.id)
     
            defmean2 = result[0]['meanings'][0]['definitions'][2]['definition']
            meaning2 = Meaning.create!(definition: defmean2, phrasal_id: phrasal_id) 
            meanexample2 = result[0]['meanings'][0]['definitions'][2]['example']
            meansynonyms2 = result[0]['meanings'][0]['definitions'][2]['synonyms']
            meananthonyms2 = result[0]['meanings'][0]['definitions'][2]['antonyms']
            meanbody2 = Meanbody.create!(synonyms: meansynonyms2, anthonyms:meananthonyms2, 
                                        example:meanexample2, meaning_id:meaning2.id)
           
        else if ((result[0]['meanings'][0]['definitions'].length >= 2))

            defmean0 = result[0]['meanings'][0]['definitions'][0]['definition']
            meaning0 = Meaning.create!(definition: defmean0,  phrasal_id: phrasal_id)
            meanexample0 = result[0]['meanings'][0]['definitions'][0]['example']
            meansynonyms0 = result[0]['meanings'][0]['definitions'][0]['synonyms']
            meananthonyms0 = result[0]['meanings'][0]['definitions'][0]['antonyms']
            meanbody0 = Meanbody.create!(synonyms: meansynonyms0, anthonyms:meananthonyms0, 
                                        example:meanexample0, meaning_id:meaning0.id)

          
            defmean1 = result[0]['meanings'][0]['definitions'][1]['definition']
            meaning1 = Meaning.create!(definition: defmean1,  phrasal_id: phrasal_id)
            meanexample1 = result[0]['meanings'][0]['definitions'][1]['example']
            meansynonyms1 = result[0]['meanings'][0]['definitions'][1]['synonyms']
            meananthonyms1 = result[0]['meanings'][0]['definitions'][1]['antonyms']
            meanbody1 = Meanbody.create!(synonyms: meansynonyms1, anthonyms:meananthonyms1, 
                                        example:meanexample1, meaning_id:meaning1.id)

            else
                defmean0 = result[0]['meanings'][0]['definitions'][0]['definition']
                meaning0 = Meaning.create!(definition: defmean0,  phrasal_id: phrasal_id)
                meanexample0 = result[0]['meanings'][0]['definitions'][0]['example']
                meansynonyms0 = result[0]['meanings'][0]['definitions'][0]['synonyms']
                meananthonyms0 = result[0]['meanings'][0]['definitions'][0]['antonyms']
                meanbody0 = Meanbody.create!(synonyms: meansynonyms0, anthonyms:meananthonyms0, 
                                            example:meanexample0, meaning_id:meaning0.id)
            end    
        end 
    end    
end

#I should seed at least 20 phrases
get_id = (Verb.where("name = 'get'"))[0].id
come_id =(Verb.where("name = 'come'"))[0].id
take_id =(Verb.where("name = 'take'"))[0].id
keep_id =(Verb.where("name = 'keep'"))[0].id
call_id =(Verb.where("name = 'call'"))[0].id


phrase1 = Phrase.create!(
            question: "And that is precisely the point Paul is trying to __________",
            answer: "get across",
            verb_id: get_id
)
phrase2 = Phrase.create!(
            question: "You can __________ your coat and stay a while. ",
            answer: "take off",
            verb_id: take_id
)




