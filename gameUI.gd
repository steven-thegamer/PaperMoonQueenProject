extends CanvasLayer

@onready var menu = $pause_menu

signal open_menu
signal close_menu

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	if menu.visible == false:
		open_menu.emit()
		menu.show()
	else:
		close_menu.emit()
		menu.hide()
