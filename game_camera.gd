extends Camera2D

const camera_movement_speed := 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = clamp(position.x,limit_left + 320,limit_right - 320)
	position.y = clamp(position.y,limit_top + 180, limit_bottom - 180)
	
	if Input.is_action_pressed("down"):
		position.y += camera_movement_speed
	if Input.is_action_pressed("left"):
		position.x -= camera_movement_speed
	if Input.is_action_pressed("right"):
		position.x += camera_movement_speed
	if Input.is_action_pressed("up"):
		position.y -= camera_movement_speed
