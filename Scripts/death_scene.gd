extends Node3D

@onready var anim_player = $"Unknown Creature(rigged)/ucAnimPlay"
@onready var bloodAnimPlayer = $DeathAnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.play()
	anim_player.play("Attack")

func _on_uc_anim_play_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "Attack"):
		$UI/Blood.visible = !$UI/Blood.visible
		bloodAnimPlayer.play("BloodTransition")
		await get_tree().create_timer(1.5).timeout
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$UI/Pause_Main_Menu.visible = !$UI/Pause_Main_Menu.visible

func _on_try_again_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/PlayMap.tscn")

func _on_return_menu_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/MainMenu.tscn")
