extends Node

var card

func set_card(new_card):
	card = new_card
	var path = "res://textures/cards/%s/%s%s.tres"
	var full_path = path % [card.suit, card.suit, card.rank]
	$Sprite2D.texture = load(full_path)
	print(full_path)
