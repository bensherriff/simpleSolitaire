import 'package:flutter/material.dart';
import 'package:solitaire/utilities.dart';
import 'playing_card.dart';
import 'transformed_card.dart';

typedef CardAcceptCallback = Null Function(List<PlayingCard> cards, int currentColumnIndex);

// This is a stack of overlayed cards (implemented using a stack)
class CardColumn extends StatefulWidget {

  // List of cards in the stack
  final List<PlayingCard> cards;

  // Callback when card is added to the stack
  final CardAcceptCallback onCardsAdded;
  final CardClickCallback onClick;

  // The index of the list in the game
  final int columnIndex;


  const CardColumn({Key? key,
    required this.cards,
    required this.onCardsAdded,
    required this.onClick,
    required this.columnIndex,
  }) : super(key: key);

  @override
  CardColumnState createState() => CardColumnState();
}

class CardColumnState extends State<CardColumn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Utilities.cardWidth + 30,
      margin: const EdgeInsets.all(2.0),
      child: DragTarget<Map>(
        builder: (context, listOne, listTwo) {
          return Stack(
            children: widget.cards.map((card) {
              int index = widget.cards.indexOf(card);
              return TransformedCard(
                playingCard: card,
                transformIndex: index,
                attachedCards: widget.cards.sublist(index, widget.cards.length),
                columnIndex: widget.columnIndex,
                onClick: (cards, currentColumnIndex) {
                  widget.onClick(cards, currentColumnIndex);
                },
              );
            }).toList(),
          );
        },
        onWillAccept: (value) {
          // Get dragged cards list
          if (value != null) {
            List<PlayingCard> draggedCards = value["cards"];
            PlayingCard firstCard = draggedCards.first;

            // If empty and king, accept
            if (widget.cards.isEmpty) {
              if (firstCard.rank == CardRank.king) {
                return true;
              } else {
                return false;
              }
            }

            if (firstCard.cardColor == CardColor.red) {
              if (widget.cards.last.cardColor == CardColor.red) {
                return false;
              }

              int lastColumnCardIndex = CardRank.values.indexOf(widget.cards.last.rank);
              int firstDraggedCardIndex = CardRank.values.indexOf(firstCard.rank);

              if(lastColumnCardIndex != firstDraggedCardIndex + 1) {
                return false;
              }

            } else {
              if (widget.cards.last.cardColor == CardColor.black) {
                return false;
              }

              int lastColumnCardIndex = CardRank.values.indexOf(widget.cards.last.rank);
              int firstDraggedCardIndex = CardRank.values.indexOf(firstCard.rank);

              if(lastColumnCardIndex != firstDraggedCardIndex + 1) {
                return false;
              }

            }
          }
          return true;
        },
        onAccept: (value) {
          widget.onCardsAdded(
            value["cards"],
            value["currentColumnIndex"],
          );
        },
      )
    );
  }
}