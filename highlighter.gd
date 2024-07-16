extends Node2D


const highlighter_type := {
	"dirt" : 0,
	"grass_spring" : 64,
	"grass_summer" : 128,
	"grass_autumn" : 192,
	"grass_winter" : 256,
	"snow" : 320
}

@onready var cube = $cube

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_highlighter(highlight_string : String):
	cube.texture.region = Rect2(0,highlighter_type[highlight_string],64,64)
