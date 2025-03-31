extends Node

var row
var collumn
var card
var hidden
var on_click_event: Callable

func set_position(slot_row, slot_collumn):
	row = slot_row
	collumn = slot_collumn

func set_card(new_card):
	card = new_card

func set_click_event_handler(action: Callable):
	on_click_event = action
	
func set_visibility(hide_card):
	assert(card != null)
	hidden = hide_card
	_set_sprite()
	
func clear_slot():
	card = null
	$Sprite2D.texture = load("res://textures/cards/others/placeholder.tres")
	
func _set_sprite():
	var path
	if (hidden):
		path = "res://textures/cards/others/cardback.tres"
	else:
		path = "res://textures/cards/%s/%s%s.tres" % [card.suit, card.suit, card.rank]
	$Sprite2D.texture = load(path)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (!hidden and event is InputEventMouseButton):
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				on_click_event.call(row, collumn, card)
