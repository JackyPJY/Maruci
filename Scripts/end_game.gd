extends Control

@onready var scoreReader = $Pause_Main_Menu/Main_Menu/General/VBoxContainer/Scoring2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var time = Global.remainTime
	var minutes = fmod(time, 3600) / 60
	var seconds = fmod(time,60)
	$Pause_Main_Menu/Main_Menu/General/VBoxContainer/HBoxContainer/Minutes.text = "%02d:" % minutes
	$Pause_Main_Menu/Main_Menu/General/VBoxContainer/HBoxContainer/Seconds.text = "%02d" % seconds
	scoreReader.text("%02d:%02d" % [minutes, seconds])
