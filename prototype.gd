extends Node2D

@onready var tilemap = $TileMap
@onready var state_machine = $StateMachine

func _ready():
	print(state_machine)
	#state_machine.transition('transition_here')

func _on_canvas_layer_open_menu():
	state_machine.transition("pause")

func _on_canvas_layer_close_menu():
	state_machine.transition("idle")
