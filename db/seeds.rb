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

Meanbody.delete_all
Meaning.delete_all
Phrasal.delete_all
Phrase.delete_all
Verb.delete_all
Prepadv.delete_all
User.delete_all



somephrasalverbs = ['get%20across', 'get%20ahead', 'get%20over', 'get%20at',
                    'come%20across',  'come%20on', 'come%20back', 'come%20up',
                    'take%20out', 'take%20off', 'take%20up', 'take%20over',
                    'keep%20down', 'keep%20away', 'keep%20on', 'keep%20back',
                    'call%20up', 'call%20off', 'call%20forth', 'call%20for']

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
        puts "k"
        puts k
        hash = Hash.new
        hash['name'] = verbasocprep[k]
        prepadv = Prepadv.find_or_create_by!(hash)
        verb.prepadvs << prepadv
        
        lookverb = verb.id
        lookprepadv = prepadv.id
        phrasal_id_obj = Phrasal.where(verb_id: lookverb, prepadv_id: lookprepadv)
        phrasal_id = phrasal_id_obj[0].id
        puts "verbo"
        puts lookverb
        puts verb.name
        puts "preposicion"
        puts lookprepadv
        puts prepadv.name
        puts "phrasal"
        puts phrasal_id
        lookfor = verb.name+'%20'+prepadv.name
        puts "lookfor"
        puts lookfor
        url = "https://api.dictionaryapi.dev/api/v2/entries/en/" + lookfor #API with definition of Phrasal Verb
        response = RestClient::Request.execute(method: :get, url: url)
        result = JSON.parse response.to_str #Answer API



        if((result[0]['meanings'][0]['definitions'].length >= 3))
            defmean0 = result[0]['meanings'][0]['definitions'][0]['definition']
            meaning0 = Meaning.create!(definition: defmean0,  phrasal_id: phrasal_id) 
            puts "meaning 0"
            puts meaning0.definition
            meanexample0 = result[0]['meanings'][0]['definitions'][0]['example']
            meansynonyms0 = result[0]['meanings'][0]['definitions'][0]['synonyms']
            meananthonyms0 = result[0]['meanings'][0]['definitions'][0]['antonyms']
            meanbody0 = Meanbody.create!(synonyms: meansynonyms0, anthonyms:meananthonyms0, 
                                        example:meanexample0, meaning_id:meaning0.id)

            defmean1 = result[0]['meanings'][0]['definitions'][1]['definition']
            meaning1 = Meaning.create!(definition: defmean1,  phrasal_id: phrasal_id) 
            puts "meaning 1"
            puts meaning1.definition
            meanexample1 = result[0]['meanings'][0]['definitions'][1]['example']
            meansynonyms1 = result[0]['meanings'][0]['definitions'][1]['synonyms']
            meananthonyms1 = result[0]['meanings'][0]['definitions'][1]['antonyms']
            meanbody1 = Meanbody.create!(synonyms: meansynonyms1, anthonyms:meananthonyms1, 
                                        example:meanexample1, meaning_id:meaning1.id)
     
            defmean2 = result[0]['meanings'][0]['definitions'][2]['definition']
            meaning2 = Meaning.create!(definition: defmean2, phrasal_id: phrasal_id) 
            puts "meaning 2"
            puts meaning2.definition

            meanexample2 = result[0]['meanings'][0]['definitions'][2]['example']
            meansynonyms2 = result[0]['meanings'][0]['definitions'][2]['synonyms']
            meananthonyms2 = result[0]['meanings'][0]['definitions'][2]['antonyms']
            meanbody2 = Meanbody.create!(synonyms: meansynonyms2, anthonyms:meananthonyms2, 
                                        example:meanexample2, meaning_id:meaning2.id)
           
        else if ((result[0]['meanings'][0]['definitions'].length >= 2))

            defmean0 = result[0]['meanings'][0]['definitions'][0]['definition']
            meaning0 = Meaning.create!(definition: defmean0,  phrasal_id: phrasal_id)
            puts "meaning 0"
            puts meaning0.definition
            meanexample0 = result[0]['meanings'][0]['definitions'][0]['example']
            meansynonyms0 = result[0]['meanings'][0]['definitions'][0]['synonyms']
            meananthonyms0 = result[0]['meanings'][0]['definitions'][0]['antonyms']
            meanbody0 = Meanbody.create!(synonyms: meansynonyms0, anthonyms:meananthonyms0, 
                                        example:meanexample0, meaning_id:meaning0.id)

          
            defmean1 = result[0]['meanings'][0]['definitions'][1]['definition']
            meaning1 = Meaning.create!(definition: defmean1,  phrasal_id: phrasal_id)
            puts "meaning 1"
            puts meaning1.definition
            meanexample1 = result[0]['meanings'][0]['definitions'][1]['example']
            meansynonyms1 = result[0]['meanings'][0]['definitions'][1]['synonyms']
            meananthonyms1 = result[0]['meanings'][0]['definitions'][1]['antonyms']
            meanbody1 = Meanbody.create!(synonyms: meansynonyms1, anthonyms:meananthonyms1, 
                                        example:meanexample1, meaning_id:meaning1.id)

            else
                defmean0 = result[0]['meanings'][0]['definitions'][0]['definition']
                meaning0 = Meaning.create!(definition: defmean0,  phrasal_id: phrasal_id)
                puts "meaning 0"
                puts meaning0.definition
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
phrase3 = Phrase.create!(
            question: "All the priests have  __________  to their places of apostolate",
            answer: "come back",
            verb_id: come_id
)
phrase4 = Phrase.create!(
            question: "And of course __________   working with all our other projects.",
            answer: "keep on",
            verb_id: keep_id
)
phrase5 = Phrase.create!(
            question: "She asked if one of you guys can __________ the role.",
            answer: "take up",
            verb_id: take_id
)
phrase6 = Phrase.create!(
            question: "He's the only one that can __________ the wedding.",
            answer: "call off",
            verb_id: call_id
)
phrase7 = Phrase.create!(
            question: "He probably feels obligated to __________ the workload.",
            answer: "take over",
            verb_id: take_id
)
phrase8 = Phrase.create!(
            question: "What makes it so difficult to  __________ the costs required to maintain information systems?",
            answer: "keep down",
            verb_id: keep_id
)
phrase9 = Phrase.create!(
            question: "We  __________ numerous unexpected circumstances in our day-to-day life",
            answer: "come across",
            verb_id: come_id
)
phrase10 = Phrase.create!(
            question: "You can rent a car to __________  the park.",
            answer: "get at",
            verb_id: get_id
)
phrase11 = Phrase.create!(
            question: "He couldn't find a better time to __________ !",
            answer: "call up",
            verb_id: call_id
)
phrase12 = Phrase.create!(
            question: "He asked them how their project was __________ !",
            answer: "coming on",
            verb_id: come_id
)
phrase13 = Phrase.create!(
            question: "She could not  __________ her fear of the dark !",
            answer: "get over",
            verb_id: get_id
)
phrase14 = Phrase.create!(
            question: "Fifty or sixty years ago, the European project did not  __________  enthusiasm from all the peoples of Europe",
            answer: "call forth",
            verb_id: call_id
)
phrase15 = Phrase.create!(
            question: "We went to CBR and ordered a  __________ meal",
            answer: "take out",
            verb_id: take_id
)
phrase17 = Phrase.create!(
            question: "The mountains  __________  the wind.",
            answer: "keep back",
            verb_id: keep_id
)
phrase18 = Phrase.create!(
            question: "This is an electric device, __________ from water.",
            answer: "keep away",
            verb_id: keep_id
)
phrase18 = Phrase.create!(
            question: "The subject _________ at the meeting.",
            answer: "came up",
            verb_id: come_id
)
phrase19 = Phrase.create!(
            question: "The job  __________ excellent communication and networking skills.",
            answer: "calls for",
            verb_id: call_id
)
phrase20 = Phrase.create!(
            question: "We know that, to __________  here, one must learn English",
            answer: "get ahead",
            verb_id: get_id
)

sss = User.create!(username: "Sesonia", password_digest:"1234", email:"serrano_sonia@hotmail.com")


