require 'byebug'
class Hand

  # This is a *factory method* that creates and returns a `Hand`
  # object.
  def self.deal_from(deck)
    hand = deck.take(2)
    self.new(hand)
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards

  end

  def points
    total = 0
    @cards.each do |card|
      if total <= 10 && card.value == :ace
        total += 11
      elsif total > 10 && card.value == :ace
        total += 1
      else
        total += card.blackjack_value
      end
    end
    total
  end

  def busted?
    self.points > 21
  end

  def hit(deck)
    raise("already busted") if busted?
    @cards += deck.take(1)
  end

  def beats?(other_hand)
    if self.busted?
      return false
    elsif self.points > other_hand.points
      return true
    elsif other_hand.busted?
      return true
    else
      return false
    end
    # self.points > other_hand.points && self.points <= 21
  end

  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end
