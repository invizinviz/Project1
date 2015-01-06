class Move < ActiveRecord::Base
  belongs_to :user
  belongs_to :ttt

  validate :if_ttt_active, on: :create
  validate :check_if_occuppied, on: :create
  validate :is_users_turn, on: :create
  validates :position, numericality: { only_integer: true, less_than: 9 }
  validate :max_move

  after_create :check_win
  validate :is_draw

  def is_draw
    errors.add(:ttt_id, "Draw game!") if ttt.is_draw?
  end

  def if_ttt_active
    errors.add(:ttt_id, "Game over!") if !ttt.is_match_active?
  end

  def check_win
    # self.errors.add(:mark, "Game over!") if ttt.is_player_win?(user.id)
    ttt.match_won
  end

  def max_move
    ttt.moves.count < 10
  end

  def check_if_occuppied
    positions = ttt.moves.map {|move| move.position}
    self.errors.add(:position, "Already taken") if positions.include? self.position
  end

  def is_users_turn
   errors.add(:user_id, "it's not your turn!") unless ttt.whose_turn.id == user_id
   ttt.reload
  end

end
