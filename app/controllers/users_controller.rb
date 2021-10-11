class UsersController < ApplicationController
    def index 
        users = User.all
        render json: users
    end

    #def show
    #   users = where_meaning
    #    render json: meanings
    #end

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

    #Trabajando en esta
    def add_verb 
        user = find_user
        verb = Verb.find(params[:verb_id])
        rate = params[:rate].to_f
        user.verbs << verb
        (User.where(id: user.id).first.joins(:verbs).where(id: verb.id)).update(user_params_verbs)
        #userupdrate= ((User.includes(:verbs).where(users: {id:user.id})).where(verbs: {id:verb.id})).update(user_params_verbs)
        render json: user, include: :verbs
    end
 
    def show_users_phrasal
       user = find_user
       render json: user, include: :phrasals
    end


    def show_users_verb
        user = find_user
        render json: user, include: :verbs
    end


    private

    def find_user
        User.find(params[:id])
    end

    
    def user_params
        params.require(:users).permit(:phrasals)
    end

    def user_params_verbs
        params.permit(:successverbs [:rate])
    end
    

end
