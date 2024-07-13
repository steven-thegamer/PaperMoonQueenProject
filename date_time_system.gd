extends Node2D

var month_id := 3
var time_minutes := 0
var time_hour := 6
var season := "SPR"
var month := "MAR"

const season_string := ["WIN","SPR","SUM","AUT"]
const month_string := ["DEC","JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV"]
const wait_time_fast := 0.01
const wait_time_normal := 0.025

@onready var timer = $Timer

signal change_season

func _ready():
	if time_hour > 22 or time_hour < 6:
		timer.wait_time = wait_time_fast
	else:
		timer.wait_time = wait_time_normal

func _process(delta):
	if time_hour > 22 or time_hour < 6:
		timer.wait_time = wait_time_fast
	else:
		timer.wait_time = wait_time_normal

func _on_timer_timeout():
	time_minutes += 10
	if time_minutes == 60:
		time_minutes = 0
		time_hour += 1
		if time_hour == 24:
			time_hour = 0
			month_id = ((month_id + 1) % 12)
	if season != season_string[(month_id / 3) % 4]:
		change_season.emit()
	season = season_string[int(month_id / 3)]
	month = month_string[month_id]
