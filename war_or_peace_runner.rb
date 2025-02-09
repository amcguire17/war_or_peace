require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class Game
  attr_reader :standard_deck, :deck1, :deck2, :player1, :player2, :turn

  def start
    p "Welcome to War! (or Peace) This game will be played with 52 cards."
    p "The players today are Megan and Aurora"
    p "Type 'GO' to start the game!"
    p "-------------------------------------------------------------------"
    print "Type Here: "
    if to_start = gets.chomp.upcase == "GO"
      create_deck
      shuffle_deck
      split_deck
      add_players
      turns
    else
      "Try again"
    end
  end

  def create_deck
    suits = [:heart, :diamond, :spades, :club]
    ranks_values = [
      [2, '2'],
      [3, '3'],
      [4, '4'],
      [5, '5'],
      [6, '6'],
      [7, '7'],
      [8, '8'],
      [9, '9'],
      [10, '10'],
      [11, 'Jack'],
      [12, 'Queen'],
      [13, 'King'],
      [14, 'Ace']
    ]

    @standard_deck = []

    suits.map do |suit|
      ranks_values.map do |rank, value|
        card = Card.new(suit, value, rank)
        @standard_deck << card
      end
    end
  end

  def shuffle_deck
    @standard_deck.shuffle!
  end

  def split_deck
    @deck1 = (deck1 = Deck.new(@standard_deck[0..25]))
    @deck2 = (deck2 = Deck.new(@standard_deck[26..51]))
  end

  def add_players
    @player1 = (player1 = Player.new('Megan', @deck1))
    @player2 = (player2 = Player.new('Aurora', @deck2))
  end

  def turns
    @turn = (turn = Turn.new(@player1, @player2))

    turn_count = 0

    loop do
      turn_count += 1
      if @turn.type == :end_game
        if @turn.player1.has_lost? == true
          p "*~*~*~* #{@turn.player2.name} has won the game! *~*~*~*"
        elsif @turn.player2.has_lost? == true
          p "*~*~*~* #{@turn.player1.name} has won the game! *~*~*~*"
        end
        break
      elsif turn_count > 1000000
        p "---- DRAW ----"
        break
      end
      @turn.type
      winner = @turn.winner
      if @turn.type == :mutually_assured_destruction
        winner = nil
        p "Turn #{turn_count}: *mutually assured destruction* 6 cards removed from play"
      elsif @turn.type == :basic
        p "Turn #{turn_count}: #{winner.name} won 2 cards"
      else
        p "Turn #{turn_count}: WAR - #{winner.name} won 6 cards"
      end
      @turn.pile_cards
      @turn.award_spoils(winner)
      if turn_count % 5000 == 0
        @turn.player1.deck.cards.shuffle!
        @turn.player2.deck.cards.shuffle!
      end
      # p @turn.player1.deck.cards.length
      # p @turn.player2.deck.cards.length
    end
  end

end

game = Game.new
p game.start
