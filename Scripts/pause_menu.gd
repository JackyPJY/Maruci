extends Control

signal UI(body)

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var Music_BUS_ID = AudioServer.get_bus_index("Music")
@onready var paused = false
@onready var pressed
@onready var timer

func _process(delta: float) -> void:
	if paused:
		if timer > 0:
			timer -= 1
		if Input.is_action_just_pressed("Pause") and timer <= 0:
			get_tree().paused = false
			$".".visible = !$".".visible
			Global.pause = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
		#if mouse_mode == false:
			#$PauseUI.visible = !$PauseUI.visible
			#get_tree().paused = true
			#Global.pause = true
			#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			#mouse_mode = true
		#elif mouse_mode == true:
			#get_tree().paused = false
			#$PauseUI.visible = !$PauseUI.visible
			#Global.pause = false
			#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			#mouse_mode = false

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(Music_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(Music_BUS_ID, value < 0.05)

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)

func _on_options_pressed() -> void:
	$Sound_Settings.visible = !$Sound_Settings.visible
	$Pause_Main_Menu.visible = !$Pause_Main_Menu.visible

func _on_back_pressed() -> void:
	$Sound_Settings.visible = !$Sound_Settings.visible
	$Pause_Main_Menu.visible = !$Pause_Main_Menu.visible

func _on_return_menu_pressed() -> void:
	$ColorRect.visible = !$ColorRect.visible
	$AnimationPlayer.play("PauseScreen")
	await get_tree().create_timer(1).timeout
	get_tree().paused = false
	Global.pause = false
	get_tree().change_scene_to_file("res://Scene/MainMenu.tscn")

func _on_continue_pressed() -> void:
	$".".visible = !$".".visible
	get_tree().paused = false
	Global.pause = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.player.mouse_mode = false


func _on_player_paused(bool: Variant) -> void:
	timer = 3
	paused = true
	pressed = false
	$".".visible = true
	get_tree().paused = true
	Global.pause = true
	$Pause_Main_Menu.visible = true
	$Sound_Settings.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	_process(0)
