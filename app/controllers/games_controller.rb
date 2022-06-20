class GamesController < ApplicationController
    private

    # Getter 
    attr_reader :current_user

    # Retorna las partidas relacionadas al usuario actual, ya sea como X o como O
    def base_query
        Game.where('player_x_id = :user or player_o_id = :user', 
        user: current_user.id)
    end

    # Guarda la partida
    def save(game, status = 200)
        if game.save
            render status: status, json: {game: game}
        else
            render status: 400, json: {errors: game.errors.details}
        end
    end

    public

    # GET /games
    # Se pueden considerar sólo partidas terminadas
    def index
        render json:
            if (over = params[:over])
                {games: base_query.where(over: over)}
            else
                {games: base_query}
            end
    end

    # GET /games/:id
    def show
        render json: {game: base_query.find(params[:id])}
    end

    # POST /games
    def create 
        game = Game.new(player_x: current_user)
        save game, 201
    end

    # PATCH /games/:id
    # La partida se actualiza de dos maneras posibles
    def update
        # 1- Uno de los dos jugadores cambia una celda
        if (updates = params[:game]) && !updates.empty?
            game = base_query.find(params[:id])
            if (cell = updates[:cell])
                game.cells[cell[:index].to_i] = cell[:value]
            end
            if (over = updates[:over])
                game.over = over
            end
            if (turn = updates[:turn])
                game.turn = turn
            end
            save game
        else # 2- El jugador O se une a la partida
            game = Game.find(params[:id])
            if game.player_o || game.player_x == current_user
                head :bad_request
            else
                game.player_o = current_user
                save game
            end
        end
    end

end