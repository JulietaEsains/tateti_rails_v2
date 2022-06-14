class Game < ApplicationRecord
    # Relaciones
    belongs_to :player_x, class_name: 'User'
    belongs_to :player_o, class_name: 'User', required: false

    # Validaciones
    validates :player_x, presence: true
    validates :player_o, presence: true, allow_nil: true

    # Callback
    before_create :set_board

    def set_board
        self.cells = ['', '', '',
                      '', '', '',
                      '', '', '']
    end
end 