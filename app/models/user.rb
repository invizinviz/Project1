class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :x_ttts, class_name: 'Ttt', foreign_key: :player_x_id
  has_many :o_ttts, class_name: 'Ttt', foreign_key: :player_o_id
  has_many :moves

  def all_matches
    x_ttts + o_ttts
  end

  def active_matches
    self.x_ttts.map {|m| m if m.is_match_active?}.compact + self.o_ttts.map {|m| m if m.is_match_active?}.compact
  end

end
