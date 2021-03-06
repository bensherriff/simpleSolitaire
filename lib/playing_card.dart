enum CardSuit {
  spades,
  hearts,
  diamonds,
  clubs,
}

extension CardSuitString on CardSuit {
  String toShortString() {
    return toString().split('.').last;
  }
}

enum CardRank {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king
}

extension CardRankString on CardRank {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension CardRankValue on CardRank {
  int get value {
    switch (this) {
      case CardRank.ace:
        return 1;
      case CardRank.two:
        return 2;
      case CardRank.three:
        return 3;
      case CardRank.four:
        return 4;
      case CardRank.five:
        return 5;
      case CardRank.six:
        return 6;
      case CardRank.seven:
        return 7;
      case CardRank.eight:
        return 8;
      case CardRank.nine:
        return 9;
      case CardRank.ten:
        return 10;
      case CardRank.jack:
        return 11;
      case CardRank.queen:
        return 12;
      case CardRank.king:
        return 13;
      default:
        return -1;
    }
  }
}

enum CardColor {
  red,
  black,
}

// Simple playing card model
class PlayingCard {
  CardSuit suit;
  CardRank rank;
  bool revealed;

  PlayingCard({
    required this.suit,
    required this.rank,
    this.revealed = false,
  });

  CardColor get cardColor {
    if(suit == CardSuit.hearts || suit == CardSuit.diamonds) {
      return CardColor.red;
    } else {
      return CardColor.black;
    }
  }

  bool get isKing => (rank == CardRank.king);
  bool get isAce => rank == CardRank.ace;

  @override
  String toString() {
    return '{suit: $suit, rank: $rank, revealed: $revealed}';
  }
}