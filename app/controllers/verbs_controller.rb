class VerbsController < ApplicationController
    def index
        verbs = Verb.all
        render json: verbs
    end

end
