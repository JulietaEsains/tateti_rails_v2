class Game < ApplicationRecord
    # quien crea una partida es X, quien se une a una partida es O
    belongs_to :player_x, class_name: 'User'
    belongs_to :player_o, class_name: 'User', required: false

    validates :player_x, presence: true
    validates :player_o, presence: true, allow_nil: true

    before_create :set_board, :set_turn

    # inicialmente el tablero, representado por un arreglo de 9 elementos, está vacío
    def set_board
        self.cells = ['', '', '',
                      '', '', '',
                      '', '', '']
    end

    def set_turn
        self.turn = 'X'
    end
end 