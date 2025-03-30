extends Node2D

var deck = []
var slots

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slots = [
		[$"Card-1-1"],
		[$"Card-2-1", $"Card-2-2"],
		[$"Card-3-1", $"Card-3-2", $"Card-3-3"],
		[$"Card-4-1", $"Card-4-2", $"Card-4-3", $"Card-4-4"],
		[$"Card-5-1", $"Card-5-2", $"Card-5-3", $"Card-5-4", $"Card-5-5"],
		[$"Card-6-1", $"Card-6-2", $"Card-6-3", $"Card-6-4", $"Card-6-5", $"Card-6-6"],
		[$"Card-7-1", $"Card-7-2", $"Card-7-3", $"Card-7-4", $"Card-7-5", $"Card-7-6", $"Card-7-7"]
	]
	_create_deck()
	_fill_card_slots()

func _create_deck():
	for suit in Suit:
		for rank in range(1, 13):
			var real_rank = rank
			if rank == 1:
				real_rank = "A"
			if rank == 11:
				real_rank = "J"
			if rank == 12:
				real_rank = "Q"
			if rank == 13:
				real_rank = "K"
			deck.append(Card.new(real_rank, suit))
	deck.shuffle()
	
func _fill_card_slots():
	for row in slots:
		for slot in row:
			slot.set_card(deck.pop_front())

enum Suit {CLUBS, SPADES, DIAMONDS, HEARTS}
