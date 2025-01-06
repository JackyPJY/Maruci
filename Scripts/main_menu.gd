extends CanvasLayer

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var Music_BUS_ID = AudioServer.get_bus_index("Music")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Difficulty.difficulty = 0
	$AnimationPlayer.play("Black_Background")
	$AnimationPlayer2.play("MainMenu_Camera")

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(Music_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(Music_BUS_ID, value < 0.05)

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)


func _on_settings_pressed() -> void:
	$UI/MarginContainer.visible = !$UI/MarginContainer.visible
	$"UI/Main_Menu".visible = !$"UI/Main_Menu".visible
	
func _on_start_pressed() -> void:
	$"UI/Main_Menu/Game_State".visible = !$"UI/Main_Menu/Game_State".visible
	$"UI/Main_Menu/General".visible = !$"UI/Main_Menu/General".visible

func _on_back_pressed() -> void:
	$"UI/Main_Menu/Game_State".visible = !$"UI/Main_Menu/Game_State".visible
	$"UI/Main_Menu/General".visible = !$"UI/Main_Menu/General".visible

func _on_easy_pressed() -> void:
	$UI/Main_Menu/Game_State/Medium.disabled = true
	$UI/Main_Menu/Game_State/Hard.disabled = true
	$UI/Main_Menu/Game_State/Back.disabled = true
	Difficulty.difficulty = 1
	Difficulty._update()
	$AnimationPlayer.play_backwards("Black_Background")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scene/PlayMap.tscn")
	print(Difficulty.difficulty)

func _on_medium_pressed() -> void:
	$UI/Main_Menu/Game_State/Easy.disabled = true
	$UI/Main_Menu/Game_State/Hard.disabled = true
	$UI/Main_Menu/Game_State/Back.disabled = true
	Difficulty.difficulty = 2
	Difficulty._update()
	$AnimationPlayer.play_backwards("Black_Background")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scene/PlayMap.tscn")

func _on_hard_pressed() -> void:
	$UI/Main_Menu/Game_State/Easy.disabled = true
	$UI/Main_Menu/Game_State/Medium.disabled = true
	$UI/Main_Menu/Game_State/Back.disabled = true
	Difficulty.difficulty = 3
	Difficulty._update()
	$AnimationPlayer.play_backwards("Black_Background")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scene/PlayMap.tscn")
