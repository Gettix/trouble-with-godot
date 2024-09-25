extends TileMapLayer

var astar = AStarGrid2D.new()

# Проблемный момент 1. Инициализация AStarGrid и отметка Wall и Void как непроходимые
func _ready() -> void:
	
	var tilemapSize = get_used_rect().end - get_used_rect().position
	var mapRect = Rect2i(-20, -10, 70, 70)
	
	var tileSize = tile_set.tile_size
	astar.region = mapRect
	astar.cell_size = tileSize
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	
	for i in tilemapSize.x:
		for j in tilemapSize.y:
			var coords = Vector2i(i, j)
			var tileData = get_cell_tile_data(coords)
			if tileData and tileData.get_custom_data('Type') == 'Wall':
				astar.set_point_solid(coords, true)
			elif tileData and tileData.get_custom_data('Type') == 'Void':
				astar.set_point_solid(coords, true)
