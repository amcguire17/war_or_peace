class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if @player1.has_lost? == true || @player2.has_lost? == true
      :end_game
    elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0)
      if @player1.deck.cards.length < 2 || @player2.deck.cards.length < 2
        :mutually_assured_destruction
      elsif @player1.deck.rank_of_card_at(2) != @player2.deck.rank_of_card_at(2)
        :war
      else
        :mutually_assured_destruction
      end
    else
      :basic
    end
  end

  def winner
    if type == :basic
      if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
        @player1
      else
        @player2
      end
    elsif type == :war
      if @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)
        @player1
      else
        @player2
      end
    elsif type == :mutually_assured_destruction
      "No Winner"
    end
  end

  def pile_cards
    if type == :basic
      @spoils_of_war << @player1.deck.remove_card
      @spoils_of_war << @player2.deck.remove_card
    elsif type == :war
      3.times { @spoils_of_war << @player1.deck.remove_card }
      3.times { @spoils_of_war << @player2.deck.remove_card }
    else
      3.times { @player1.deck.remove_card }
      3.times { @player2.deck.remove_card }
    end
  end

  def award_spoils(winner)
    @spoils_of_war.each do |card|
      winner.deck.add_card(card)
    end
    @spoils_of_war.clear
  end
end
