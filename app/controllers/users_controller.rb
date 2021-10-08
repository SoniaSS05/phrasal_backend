class UsersController < ApplicationController
    def index
        users = User.all
        render json: users
    end

    def show
        users = where_meaning
        render json: meanings
    end

    def update
        user = find_user
        user.update(user_params)
        render json: user
    end


    def upd_user_phrasal
        user = find_user
        userupd= (User.includes(:phrasals).where(users: {id:user.id})).update(user_params)
    end

    def add_phrasal  
        user = User.find(params[:id])
        phrasal = Phrasal.find(params[:phrasal_id])
      
        user.phrasals << phrasal
        render json: user, include: :phrasals
    end

    #def add_verb 
    #    user = User.find(params[:id])
    #    verb = Verb.find(params[:verb_id]) 
    #    user.verbs << verb
    #    render json: user, include: :verbs
    #end
 

    private

    def find_user
        User.find(params[:id])
    end

    

    def user_params
        params.require(:users).permit(:phrasals)
    end

end
