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
        userverb = ((User.includes(:verbs).where(users: {id:user.id})).where(verbs: {id:verb.id}))
 byebug
        userupdrate= userverb.update(user_params_verb)
       
        render json: user, include: :verbs
    end
 
    def show_users_phrasal
       user = find_user
       render json: user, include: :phrasals
    end


    def show_users_verb
        user = find_user
        render json: user, include: [:verbs, :successverbs_attributes]
    end


    private

    def find_user
        User.find(params[:id])
    end

    #def find_user_verbs
       # (User.find(params[:id])).where(verbs :{id:params[:verb_id]})
    #end
    
    def user_params
        params.require(:users).permit(:phrasals)
    end

    def user_params_verb

     params.require(:users).permit(successverb_attributes: [:rate], verb_attributes: [])

    end
    

end
