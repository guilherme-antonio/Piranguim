extends Node

var row
var collumn
var card
var visible = true
var on_click_event: Callable

func set_position(slot_row, slot_collumn):
	row = slot_row
	collumn = slot_collumn

func set_card(new_card):
	card = new_card

func set_click_event_handler(action: Callable):
	on_click_event = action
	
func set_visibility(visibility):
	visible = visibility
	
func clear_slot():
	card = null
	$Sprite2D.texture = load("res://textures/cards/others/placeholder.tres")
	
func update():
	assert(card != null)
	_set_sprite()
	
func is_empty():
	return card == null
	
func _set_sprite():
	var path
	if (visible):
		path = "res://textures/cards/%s/%s%s.tres" % [card.suit, card.suit, card.rank]
	else:
		path = "res://textures/cards/others/cardback.tres"
	$Sprite2D.texture = load(path)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (visible and row != null and collumn != null and card != null
				and event is InputEventMouseButton):
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				on_click_event.call(row, collumn, card)
