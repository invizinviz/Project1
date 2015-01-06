class Ttt < ActiveRecord::Base
  belongs_to :player_x, class_name: 'User', foreign_key: 'player_x_id'
  belongs_to :player_o, class_name: 'User', foreign_key: 'player_o_id'
  has_many :moves
  validates :player_x_id, presence: true
  validates :player_o_id, presence: true

  scope :winners, -> { where('win_id is not null') }

  WIN_LINES = [[0, 1 ,2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
  [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

  def whose_turn
   if moves.last.try(:user_id) == player_x_id
     player_o
   else
     player_x
   end
  end

  def is_player_win?(user_id)
    user_moves = moves.map { |move| move.position if move.user_id == user_id }.compact
    WIN_LINES.map { |win| (win - user_moves).empty?}.include?(true)
  end

##
  def match_won
    WIN_LINES.each do |combo|
      if (get_player_combo(player_x_id) & combo).sort == combo.sort
        set_winner(player_x_id)
        return true
      elsif (get_player_combo(player_o_id) & combo).sort == combo.sort
        set_winner(player_o_id)
        return true
      end
    end
    return false
  end

  def set_winner(user_id)
    self.win_id = user_id
    save
  end

  def is_match_active?
    moves.count < 9 && self.win_id.nil?
  end
##

  def get_player_combo(user_id)
    moves.map { |move| move.position if move.user_id == user_id }.compact
  end

  def add_move(user_id, position)
    moves.create(user_id: user_id, position: position)
  end

  def is_draw?
    if (moves.count == 9) && (is_player_win?(self.player_x_id) == false) &&  (is_player_win?(self.player_o_id) == false)
      true
    else
      false
    end
  end

  def self.leader_board
    t = Ttt.winners
    res=Hash[t.map {|p| p.win_id}.group_by {|x| x}.map {|k,v| [k,v.count]}]
    res.sort_by(&:last).reverse.map {|k , v|  " #{User.find(k).name} won: #{v} game(s) "}
    # res
  end

  def ai
    all_positions = [0,1,2,3,4,5,6,7,8]
    occupied_position = self.moves.map(&:position)
    if !occupied_position.include?(4)
      available_positions = 4
    else
      available_positions = (all_positions - occupied_position).sample
    end
  end

end
