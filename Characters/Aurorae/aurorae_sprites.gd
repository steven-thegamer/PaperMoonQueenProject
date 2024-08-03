extends Node2D

@onready var back_side = $back_side
@onready var front_side = $front_side
@onready var front_side_alt = $front_side_alt

func hide_all_sprites():
	back_side.hide()
	front_side.hide()
	front_side_alt.hide()

func front_alt_display_sprite(top : int, bottom : int, expression : int) -> void:
	front_side_alt.show()
	var animation_name = "shirt" if top == 0 else ("bra" if top == 1 else "nude") + "_" + "pants" if bottom == 0 else "nude"
	
	if expression >= front_side_alt.sprite_frames:
		return
	
	front_side_alt.play(animation_name)
	
	front_side_alt.frame = expression

func front_display_sprite(top : int, bottom : int, expression : int) -> void:
	front_side.show()
	var animation_name = "shirt" if top == 0 else ("bra" if top == 1 else "nude") + "_" + "pants" if bottom == 0 else "nude"
	
	if expression >= front_side.sprite_frames:
		return
	
	front_side.play(animation_name)
	front_side.frame = expression

func back_display_sprite(top : int, bottom : int, expression : int) -> void:
	back_side.show()
	var animation_name = "shirt" if top == 0 else ("bra" if top == 1 else "nude") + "_" + "pants" if bottom == 0 else ("panties" if bottom == 1 else "nude")
	
	if expression >= back_side.sprite_frames:
		return
	
	back_side.play(animation_name)
	back_side.frame = expression

