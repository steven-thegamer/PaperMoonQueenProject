extends AnimatableBody2D

enum move_key {LEFT,RIGHT,UP,DOWN}

const possible_movement := [Vector2(2,-1),Vector2(-2,1),Vector2(2,1),Vector2(-2,-1)]

signal done_moving

var tilemap : TileMap
var tile_position : Vector2

func _ready():
	tilemap = get_parent().tilemap

func _process(delta):
	tile_position = tilemap.local_to_map(global_position)

func move_character(intial_position : Vector2,final_position : Vector2):
	var movement_array := []
	var path_id = tilemap.astar.get_id_path(intial_position,final_position)
	var path_size = path_id.size()
	for index in range(1,path_size):
		var distance = path_id[index] - path_id[index-1]
		match distance:
			# RIGHT
			Vector2i(1,0):
				movement_array.append(1)
			# DOWN
			Vector2i(0,1):
				movement_array.append(3)
			# LEFT
			Vector2i(-1,0):
				movement_array.append(0)
			# UP
			Vector2i(0,-1):
				movement_array.append(2)
	movement_in_order(movement_array)

func movement_in_order(movement_array : Array):
	for movement_index in movement_array:
		movement(movement_index)
		await Signal(self,"done_moving")

func movement(movement_index : move_key):
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",position + possible_movement[movement_index] * 16,1)
	await get_tree().create_timer(1.0).timeout
	emit_signal("done_moving")

func _on_timer_timeout():
	pass # Replace with function body.

