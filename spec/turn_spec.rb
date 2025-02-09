require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

RSpec.describe Turn do
  describe 'initialize' do
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    deck1 = Deck.new([card1, card2, card5, card8])
    deck2 = Deck.new([card3, card4, card6, card7])
    player1 = Player.new('Megan', deck1)
    player2 = Player.new('Aurora', deck2)
    turn = Turn.new(player1, player2)

    it 'has players' do
      expect(turn).to be_an_instance_of(Turn)
      expect(turn.player1).to be_a(Player)
      expect(turn.player2).to be_a(Player)
    end

    it 'starts with no spoils' do
      expect(turn.spoils_of_war).to be_empty
    end
  end
  describe 'turn type basic' do
    it 'turn can be basic' do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10,', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, 'Queen', 12)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)
      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card3, card4, card6, card7])
      player1 = Player.new('Megan', deck1)
      player2 = Player.new('Aurora', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.type).to eq(:basic)
    end

    it 'has a winner' do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10,', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, 'Queen', 12)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)
      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card3, card4, card6, card7])
      player1 = Player.new('Megan', deck1)
      player2 = Player.new('Aurora', deck2)
      turn = Turn.new(player1, player2)

      winner = turn.winner

      expect(turn.winner).to eq(player1)
    end

    it 'can pile cards in spoils' do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10,', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, 'Queen', 12)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)
      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card3, card4, card6, card7])
      player1 = Player.new('Megan', deck1)
      player2 = Player.new('Aurora', deck2)
      turn = Turn.new(player1, player2)

      winner = turn.winner
      turn.pile_cards

      expect(turn.spoils_of_war).to eq([card1, card3])
    end

    it 'can award spoils' do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10,', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, 'Queen', 12)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)
      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card3, card4, card6, card7])
      player1 = Player.new('Megan', deck1)
      player2 = Player.new('Aurora', deck2)
      turn = Turn.new(player1, player2)

      winner = turn.winner
      turn.pile_cards
      turn.award_spoils(winner)

      expect(turn.player1.deck.cards).to eq([card2, card5, card8, card1, card3])
      expect(turn.player2.deck.cards).to eq([card4, card6, card7])
    end
  end

  describe 'turn type war' do
    it 'turn can be a war' do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, 'Queen', 12)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)
      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card4, card3, card6, card7])
      player1 = Player.new('Megan', deck1)
      player2 = Player.new('Aurora', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.type).to eq(:war)
    end

    it 'has a war winner' do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, 'Queen', 12)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)
      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card4, card3, card6, card7])
      player1 = Player.new('Megan', deck1)
      player2 = Player.new('Aurora', deck2)
      turn = Turn.new(player1, player2)

      winner = turn.winner

      expect(winner.name).to eq(turn.player2.name)
    end

    it 'can pile cards in war spoils' do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, 'Queen', 12)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)
      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card4, card3, card6, card7])
      player1 = Player.new('Megan', deck1)
      player2 = Player.new('Aurora', deck2)
      turn = Turn.new(player1, player2)

      winner = turn.winner
      turn.pile_cards

      expect(turn.spoils_of_war).to eq([card1, card2, card5, card4, card3, card6])
    end

    it 'can award war win spoils' do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, 'Queen', 12)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)
      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card4, card3, card6, card7])
      player1 = Player.new('Megan', deck1)
      player2 = Player.new('Aurora', deck2)
      turn = Turn.new(player1, player2)

      winner = turn.winner
      turn.pile_cards
      turn.award_spoils(winner)

      expect(player1.deck.cards).to eq([card8])
      expect(player2.deck.cards).to eq([card7, card1, card2, card5, card4, card3, card6])
    end
  end

  describe 'turn type mutually assured destruction' do
    it 'type can be mutually assured destruction' do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, '8', 8)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)
      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card4, card3, card6, card7])
      player1 = Player.new('Megan', deck1)
      player2 = Player.new('Aurora', deck2)
      turn = Turn.new(player1, player2)

      expect(turn.type).to eq(:mutually_assured_destruction)
    end

    it 'has a war winner' do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, '8', 8)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)
      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card4, card3, card6, card7])
      player1 = Player.new('Megan', deck1)
      player2 = Player.new('Aurora', deck2)
      turn = Turn.new(player1, player2)

      winner = turn.winner

      expect(winner).to eq("No Winner")
    end

    it 'can pile cards in war spoils' do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, '8', 8)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)
      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card4, card3, card6, card7])
      player1 = Player.new('Megan', deck1)
      player2 = Player.new('Aurora', deck2)
      turn = Turn.new(player1, player2)

      winner = turn.winner
      turn.pile_cards

      expect(turn.spoils_of_war).to be_empty
    end

    it 'can have no award spoils' do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, '8', 8)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)
      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card4, card3, card6, card7])
      player1 = Player.new('Megan', deck1)
      player2 = Player.new('Aurora', deck2)
      turn = Turn.new(player1, player2)

      winner = turn.winner
      turn.pile_cards
      turn.award_spoils(winner)

      expect(player1.deck.cards).to eq([card8])
      expect(player2.deck.cards).to eq([card7])
    end
  end
end
