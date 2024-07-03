extends Node2D

@onready var time_label = $time_label
@onready var season_label = $season_label
@onready var month_label = $month_label
@onready var timer = $Timer

var month := 3
var time_minutes := 0
var time_hour := 6

const season_string := ["WIN","SPR","SUM","AUT"]
const month_string := ["JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"]
const wait_time_fast := 0.025
const wait_time_normal := 0.1

func _ready():
	pass # Replace with function body.

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
			month += 1
			if month == 13:
				month = 1
	season_label.text = season_string[(month / 3) % 4]
	time_label.text = (str(time_hour) if str(time_hour).length() == 2 else "0" + str(time_hour)) + ":" + (str(time_minutes) if time_minutes > 0 else "00")
	month_label.text = month_string[month - 1]
