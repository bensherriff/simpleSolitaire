import 'package:flutter/material.dart';
import 'card_column.dart';
import 'playing_card.dart';

typedef CardClickCallback = Null Function(List<PlayingCard> cards, int currentColumnIndex);

// TransformedCard makes the card draggable and translates it according to
// position in the stack.
class TransformedCard extends StatefulWidget {
  final PlayingCard playingCard;
  final double transformDistance;
  final int transformIndex;
  final int columnIndex;
  final List<PlayingCard> attachedCards;
  final CardClickCallback onClick;

  TransformedCard({
    required this.playingCard,
    required this.attachedCards,
    required this.onClick,
    this.transformDistance = 15.0,
    this.transformIndex = 0,
    this.columnIndex = -1
  });

  @override
  TransformedCardState createState() => TransformedCardState();
}

class TransformedCardState extends State<TransformedCard> {
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          0.0,
          widget.transformIndex * widget.transformDistance,
          0.0,
        ),
      child: buildCardClickable()
    );
  }

  Widget buildCardClickable() {
    if (widget.playingCard.clickable) {
      return !widget.playingCard.faceUp ? Container(
        height: 60.0,
        width: 40.0,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ) : GestureDetector(
        onTap: () => widget.onClick(widget.attachedCards, widget.columnIndex),
        child: buildCard(),
      );
    } else {
      return buildCard();
    }
  }

  Widget buildCard() {
    return !widget.playingCard.faceUp ? Container(
      height: 60.0,
      width: 40.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ) : Draggable<Map>(
      child: buildFaceUpCard(),
      feedback: CardColumn(
        cards: widget.attachedCards,
        columnIndex: 1,
        onCardsAdded: (card, position) {},
        onClick: (cards, currentColumnIndex){}
      ),
      childWhenDragging: buildFaceUpCard(),
      data: {
        "cards": widget.attachedCards,
        "fromIndex": widget.columnIndex,
      },
    );
  }

  Widget buildFaceUpCard() {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        height: 60.0,
        width: 40,
        child: Stack(
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: Text(
                      cardTypeToString(),
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    child: suitToImage(),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cardTypeToString(),
                      style: const TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                      child: suitToImage(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String cardTypeToString() {
    switch (widget.playingCard.cardType) {
      case CardType.ace:
        return "A";
      case CardType.two:
        return "2";
      case CardType.three:
        return "3";
      case CardType.four:
        return "4";
      case CardType.five:
        return "5";
      case CardType.six:
        return "6";
      case CardType.seven:
        return "7";
      case CardType.eight:
        return "8";
      case CardType.nine:
        return "9";
      case CardType.ten:
        return "10";
      case CardType.jack:
        return "J";
      case CardType.queen:
        return "Q";
      case CardType.king:
        return "K";
      default:
        return "";
    }
  }

  Image? suitToImage() {
    switch (widget.playingCard.cardSuit) {
      case CardSuit.hearts:
        return Image.asset('images/hearts.png');
      case CardSuit.diamonds:
        return Image.asset('images/diamonds.png');
      case CardSuit.clubs:
        return Image.asset('images/clubs.png');
      case CardSuit.spades:
        return Image.asset('images/spades.png');
      default:
        return null;
    }
  }
}