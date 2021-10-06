class PhrasesController < ApplicationController
    def index
        phrases = Phrase.all
        render json: phrases
    end

    def show
        phrases = find_phrases
        render json: phrases
    end

    private

    def find_phrases
        Phrase.where(verb_id: params[:id])
    end
end
