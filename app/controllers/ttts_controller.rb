class TttsController < ApplicationController

  def new
    @ttt = Ttt.new
  end

  def create
    @ttt = Ttt.new(ttt_params)
    @ttt.save
    redirect_to(@ttt)
  end

  def show
    @ttt = Ttt.find(params[:id])
  end

  def move
    @ttt = Ttt.find(params[:id])
    @move = Move.new(user_id: current_user.id, position: params[:position], ttt_id: @ttt.id)
    if @move.save
      # u = @ttt.match_won
      # raise
      if @ttt.player_o_id==10 #&& !@ttt.match_won
        # raise
        @ttt.moves.create(user_id: 10, position: @ttt.ai)
      end
      redirect_to(@ttt)
    else
      render :show
    end
  end

  private
  def ttt_params
    params.require(:ttt).permit(:player_x_id, :player_o_id)
  end

end
