class Game < ApplicationRecord
    belongs_to :player_x, class_name: 'User'
    belongs_to :player_o, class_name: 'User', required: false

    validates :player_x, presence: true
    validates :player_o, presence: true, allow_nil: true

    before_create :set_board, :set_turn

    def set_board
        self.cells = ['', '', '',
                      '', '', '',
                      '', '', '']
    end

    def set_turn
        self.turn = 'X'
    end
end 