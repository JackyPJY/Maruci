extends CanvasLayer

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var Music_BUS_ID = AudioServer.get_bus_index("Music")
@onready var easyDescription = "Large Stamina\nRequired Least Scroll\nSlow Creature Speed"
@onready var normalDescription = "Normal Stamina\nScroll Increased\nFaster Creature Speed"
@onready var hardDescription = "Do not run\nBe agile\n\n  Keep Quiet"
@onready var Displayer = $UI/Main_Menu/HBoxContainer/MarginContainer/DifficultyExplainer/Displayer
@onready var Easy = $UI/Main_Menu/HBoxContainer/Game_State/Easy
@onready var Normal = $UI/Main_Menu/HBoxContainer/Game_State/Medium
@onready var Hard = $UI/Main_Menu/HBoxContainer/Game_State/Hard
@onready var back = $UI/Main_Menu/HBoxContainer/Game_State/Back

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Difficulty.difficulty = 0
	$AnimationPlayer.play("Black_Background")
	$AnimationPlayer2.play("MainMenu_Camera")

func _process(delta: float) -> void:
	if $UI/Main_Menu/HBoxContainer.visible: 
		if $UI/Main_Menu/HBoxContainer/Game_State/Easy.is_hovered():
			Displayer.visible = true
			Displayer.text = easyDescription
		if $UI/Main_Menu/HBoxContainer/Game_State/Medium.is_hovered():
			Displayer.visible = true
			Displayer.text = normalDescription
		if $UI/Main_Menu/HBoxContainer/Game_State/Hard.is_hovered():
			Displayer.visible = true
			Displayer.text = hardDescription
	if !$UI/Main_Menu/HBoxContainer/Game_State/Easy.is_hovered() and !$UI/Main_Menu/HBoxContainer/Game_State/Medium.is_hovered() and !$UI/Main_Menu/HBoxContainer/Game_State/Hard.is_hovered():
		Displayer.visible = false

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
	$UI/Main_Menu/HBoxContainer.visible = !$UI/Main_Menu/HBoxContainer.visible
	$"UI/Main_Menu/General".visible = !$"UI/Main_Menu/General".visible

func _on_back_pressed() -> void:
	$UI/Main_Menu/HBoxContainer.visible = !$UI/Main_Menu/HBoxContainer.visible
	$"UI/Main_Menu/General".visible = !$"UI/Main_Menu/General".visible

func _on_easy_pressed() -> void:
	Normal.disabled = true
	Hard.disabled = true
	back.disabled = true
	Difficulty.difficulty = 1
	Difficulty._update()
	$AnimationPlayer.play_backwards("Black_Background")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scene/PlayMap.tscn")
	print(Difficulty.difficulty)

func _on_medium_pressed() -> void:
	Easy = true
	Hard.disabled = true
	back.disabled = true
	Difficulty.difficulty = 2
	Difficulty._update()
	$AnimationPlayer.play_backwards("Black_Background")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scene/PlayMap.tscn")

func _on_hard_pressed() -> void:
	Easy = true
	Normal.disabled = true
	back.disabled = true
	Difficulty.difficulty = 3
	Difficulty._update()
	$AnimationPlayer.play_backwards("Black_Background")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scene/PlayMap.tscn")

func _on_help_pressed() -> void:
	$"UI/Main_Menu".visible = !$"UI/Main_Menu".visible
	$UI/MarginContainer2.visible = !$UI/MarginContainer2.visible

func _on_back_2_pressed() -> void:
	$UI/MarginContainer2.visible = !$UI/MarginContainer2.visible
	$"UI/Main_Menu".visible = !$"UI/Main_Menu".visible

func _on_quit_pressed() -> void:
	get_tree().quit()
