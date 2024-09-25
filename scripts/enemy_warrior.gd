extends CharacterBody2D

@onready var tilemap = $"../Map"
var currentPath: Array[Vector2i]
var target_position: Vector2
var is_moving
signal turn_completed
	
func _ready():
	target_position = position

# Проблемный момент 2. Запрос get_id_path и последующее перемещение обьекта по карте
func make_turn():
	var start = tilemap.local_to_map(position)
	var end = tilemap.local_to_map(get_enemy().position)
	currentPath = tilemap.astar.get_id_path(start, end)
	if currentPath.size() > 2:
		currentPath.pop_front()
		target_position = tilemap.map_to_local(currentPath[0])
		is_moving = true

func _physics_process(delta):
	if is_moving == true:
		if position.distance_to(target_position) > 1:
			position = position.move_toward(target_position, 100 * delta)
		else:
			is_moving = false
			turn_completed.emit()


func get_enemy():
	var closest_enemy = null
	var shortest_distance = INF
	for enemy in get_tree().get_nodes_in_group("monsters"):
		if not is_instance_valid(enemy):
			continue
		var distance = position.distance_to(enemy.position)
		if distance < shortest_distance:
			shortest_distance = distance
			closest_enemy = enemy
	return closest_enemy
