class VerbsController < ApplicationController
    def index
        verbs = Verb.all
        render json: verbs
    end

    def phrasalverb
        verbname = find_verb
        #verbnameprepadv= Prepadv.includes(:verbs).where(verbs: {name: verbname.name})
        verbnameprepadv= (Prepadv.includes(:verbs).where(verbs: {name: verbname.name})).select("phrasals.id as phrasalid, prepadvs.id as prepadvid, prepadvs.name")
        render json: verbnameprepadv
    end


    private

    def find_verb
        Verb.find(params[:id])
    end



end
