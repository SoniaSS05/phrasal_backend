class MeanbodiesController < ApplicationController
    def show
        meanbodies = where_meanbody
        render json: meanbodies
    end

    def where_meanbody
        Meanbody.where(meaning_id: params[:id])
    end
end
