extends Node2D

var deck = []
var slots
var top_card
var score_calculator

var score_text_format = "[center]Score %s[/center]"
var remaining_cards_text_format = "[center]Remaining Cards %s[/center]"

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
	_start_game()
	
func _start_game():
	score_calculator = ScoreCalculator.new(0)
	_reset_score()
	_create_deck()
	_fill_card_slots()
	_select_top_card()
	_reset_pile_texture()
	_update_remaing_cards_text()
	
func _reset_score():
	score_calculator.reset()
	$Score.text = score_text_format % 0

func _create_deck():
	deck.clear()
	for suit in Suit:
		for order in range(1, 14):
			var rank = order
			if order == 1:
				rank = "A"
			if order == 11:
				rank = "J"
			if order == 12:
				rank = "Q"
			if order == 13:
				rank = "K"
			deck.append(Card.new(order, rank, suit))
	deck.shuffle()
	
func _fill_card_slots():
	var row_count = 0
	for row in slots:
		var visible = (row == slots[slots.size() - 1])
		var collumn_count = 0
		for slot in row:
			slot.set_position(row_count, collumn_count)
			slot.set_card(deck.pop_front())
			slot.set_visibility(visible)
			slot.update()
			slot.set_click_event_handler(Callable(self, "_on_card_click"))
			collumn_count += 1
		row_count += 1
			
func _select_top_card(card = null):
	if (card == null):
		top_card = deck.pop_front()
	else:
		top_card = card
	$"Card-Top".set_card(top_card)
	$"Card-Top".update()
	score_calculator.reset()
	
func _reset_pile_texture():
	$Pile/Sprite2D.texture = load("res://textures/cards/others/cardback.tres")
			
func _on_card_click(row, collumn, card):
	if (abs(card.order - top_card.order) == 1 or abs(card.order - top_card.order) == 12):
		slots[row][collumn].clear_slot()
		_select_top_card(card)
		_check_other_cards(row, collumn)
		_add_score(row)
		
func _check_other_cards(row, collumn):
	var close_slots = _get_close_slots(row, collumn)
	if (close_slots[0] != null and close_slots[0].is_empty()):
		slots[row-1][collumn-1].set_visibility(true)
		slots[row-1][collumn-1].update()
	if (close_slots[1] != null and close_slots[1].is_empty()):
		slots[row-1][collumn].set_visibility(true)
		slots[row-1][collumn].update()
		
func _get_close_slots(row, collumn):
	var left_slot = null
	var right_slot = null
	if collumn > 0:
		left_slot = slots[row][collumn-1]
	if collumn < (slots[row].size() - 1):
		right_slot = slots[row][collumn+1]
	return [left_slot, right_slot]
	
func _add_score(row):
	$Score.text = score_text_format % score_calculator.get_score(row)
	
func _update_remaing_cards_text():
	$RemainingCardsText.text = remaining_cards_text_format % deck.size()

func _on_pile_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton):
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if (!deck.is_empty()):
					_select_top_card()
					_update_remaing_cards_text()
					if (deck.is_empty()):
						$Pile/Sprite2D.texture = load("res://textures/cards/others/placeholder.tres")

func _on_reset_pressed() -> void:
	_start_game()

enum Suit {CLUBS, SPADES, DIAMONDS, HEARTS}
