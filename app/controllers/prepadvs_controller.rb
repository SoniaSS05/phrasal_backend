class PrepadvsController < ApplicationController
    def index
        prepadvs = Prepadv.all
        render json: prepadvs
    end
end
