class MeaningsController < ApplicationController
    def index
        meanings = Meaning.all
        render json: meanings
    end

    def show
        meanings = where_meaning
        render json: meanings
    end

    private

    def where_meaning
        Meaning.where(phrasal_id: params[:id])
      
   
    end
end
