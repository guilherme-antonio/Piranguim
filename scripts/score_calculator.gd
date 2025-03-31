class_name ScoreCalculator

var consecutives = 0
var score
var base_scores = [502, 27, 17, 12, 7, 4, 3]
var consecutive_bonus = 2

func _init(initial_score):
	score = initial_score
	
func reset():
	consecutives = 0

func get_score(row):
	var next_score = base_scores[row] + consecutives * consecutive_bonus
	score += next_score
	consecutives += 1
	return score
