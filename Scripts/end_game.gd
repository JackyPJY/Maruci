extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var time = Global.remainTime
	var minutes = fmod(time, 3600) / 60
	var seconds = fmod(time,60)
	$Pause_Main_Menu/Main_Menu/General/VBoxContainer/HBoxContainer/Minutes.text = "%02d:" % minutes
	$Pause_Main_Menu/Main_Menu/General/VBoxContainer/HBoxContainer/Seconds.text = "%02d" % seconds

func _on_return_menu_pressed() -> void:
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scene/MainMenu.tscn")
