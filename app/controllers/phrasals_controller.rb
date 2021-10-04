class PhrasalsController < ApplicationController
    def index
        phrasal = Phrasal.all
        render json: phrasal
    end
end