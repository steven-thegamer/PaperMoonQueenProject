extends TileMap

signal position_selected(location)
@onready var highlighter = $highlighter

var astar := AStarGrid2D.new()

func _ready():
	astar.region = Rect2i(-64,-64,128,128)
	astar.cell_size = Vector2(1, 1)
	astar.diagonal_mode = astar.DIAGONAL_MODE_NEVER
	astar.default_compute_heuristic = 1
	astar.default_estimate_heuristic = 1
	astar.update()
	for i in range(astar.region.position.x,astar.region.position.x + astar.region.size.x):
		for j in range(astar.region.position.y,astar.region.position.y + astar.region.size.y):
			if get_cell_source_id(0,Vector2i(i,j)) == -1:
				astar.set_point_solid(Vector2i(i,j))

func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	var tile_pos = map_to_local(local_to_map(mouse_pos))
	highlighter.global_position = tile_pos

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var mouse_pos = get_global_mouse_position()
		var tile_pos = map_to_local(local_to_map(mouse_pos))
		if get_cell_source_id(0,local_to_map(mouse_pos)) == -1 and get_cell_atlas_coords(0,local_to_map(mouse_pos)) == Vector2i(-1,-1):
			create_dirt(mouse_pos,0)
			
func get_neighbors(tile_coordinate : Vector2, layer : int):
	var neighbors = []
	for tile_pos in [Vector2(0,1),Vector2(1,0),Vector2(-1,0),Vector2(0,-1)]:
		var tile_position = tile_coordinate + tile_pos
		if get_cell_source_id(layer,tile_coordinate) != -1 and get_cell_atlas_coords(layer, tile_coordinate) != Vector2i(-1,-1):
			neighbors.append(tile_position)
	return neighbors

func create_dirt(location, layer):
	var tile_pos = local_to_map(location)
	set_cell(layer,tile_pos,0,Vector2i(randi() % 4,0))
