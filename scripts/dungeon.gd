extends Node2D

@onready var temp_enemy_warrior = $CharacterBody2D
var is_turn_proceed
var task_comleted

func _ready():
	is_turn_proceed = false
	task_comleted = false
	
	Global.entities['adv'].append(temp_enemy_warrior)
	Global.entities['monsters'].append($Goblin)
	Global.turn = 'adv'

	task_comleted = true
	
func _process(_delta) -> void:
	if task_comleted == true:
		task_comleted = false
		turn_manager()
		
func turn_completed():
	is_turn_proceed = false
	
func turn_manager():
	if Global.turn == 'monster':
		for adv in Global.entities['adv']:
			is_turn_proceed = true
			adv.make_turn()
			await is_turn_proceed
			await get_tree().create_timer(0.5).timeout
		Global.turn = 'adv'
	elif Global.turn == 'adv':
		for monster in Global.entities['monsters']:
			is_turn_proceed = true
			monster.make_turn()
			await is_turn_proceed
			await get_tree().create_timer(0.5).timeout
		Global.turn = 'monster'
	task_comleted = true
	
