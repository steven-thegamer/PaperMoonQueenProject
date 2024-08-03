extends Node2D
class_name season_system

@onready var time_label = $time_label
@onready var season_label = $season_label
@onready var month_label = $month_label
@onready var season_icon = $AnimatedSprite2D

signal change_season

func _ready():
	DateTimeSystem.timer.timeout.connect(update_display)
	DateTimeSystem.timer.start()

func update_display():
	time_label.text = (str(DateTimeSystem.time_hour) if str(DateTimeSystem.time_hour).length() == 2 else "0" + str(DateTimeSystem.time_hour)) + ":" + (str(DateTimeSystem.time_minutes) if DateTimeSystem.time_minutes > 0 else "00")
	month_label.text = DateTimeSystem.month
	season_label.text = DateTimeSystem.season
	season_icon.frame = 0 if season_label.text == "SPR" else(1 if season_label.text == "SUM" else (2 if season_label.text == "AUT" else 3))
