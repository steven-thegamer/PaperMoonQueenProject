extends Node2D

@onready var back_side = $back_side
@onready var front_side = $front_side
@onready var front_side_alt = $front_side_alt

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func front_alt_display_sprite(top : int, bottom : int, expression : int) -> void:
	if top == 0:
		if bottom == 0:
			front_side_alt.play("normal")
		elif bottom == 1:
			front_side_alt.play("pantsless")
		else:
			return
	elif top == 1:
		if bottom == 0:
			front_side_alt.play("shirtless")
		elif bottom == 1:
			front_side_alt.play("shirtless_pantsless")
		else:
			return
	elif top == 2:
		if bottom == 0:
			front_side_alt.play("braless")
		elif bottom == 2:
			front_side_alt.play("nude")
		else:
			return
	else:
		return
	
	if expression >= front_side_alt.sprite_frames:
		return
	
	front_side_alt.frame = expression

func front_display_sprite(top : int, bottom : int, expression : int) -> void:
	if top == 0:
		if bottom == 0:
			front_side.play("normal")
		elif bottom == 1:
			front_side.play("pantsless")
		else:
			return
	elif top == 1:
		if bottom == 0:
			front_side.play("shirtless")
		elif bottom == 1:
			front_side.play("shirtless_pantsless")
		else:
			return
	elif top == 2:
		if bottom == 0:
			front_side.play("braless")
		elif bottom == 2:
			front_side.play("nude")
		else:
			return
	else:
		return
	
	if expression >= front_side.sprite_frames:
		return
	
	front_side.frame = expression

func back_display_sprite(top : int, bottom : int, expression : int) -> void:
	if top == 0:
		if bottom == 0:
			back_side.play("normal")
		elif bottom == 1:
			back_side.play("pantsless")
		elif bottom == 2:
			return
		else:
			return
	elif top == 1:
		if bottom == 0:
			back_side.play("shirtless")
		elif bottom == 1:
			back_side.play("shirtless_pantsless")
		elif bottom == 2:
			back_side.play("shirtless_pantiesless")
		else:
			return
	elif top == 2:
		if bottom == 0:
			back_side.play("braless")
		elif bottom == 1:
			back_side.play("braless_pantsless")
		elif bottom == 2:
			back_side.play("nude")
		else:
			return
	else:
		return
	
	if expression >= back_side.sprite_frames:
		return
	
	back_side.frame = expression

