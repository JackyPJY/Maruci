class_name CrouchWalkingPlayerState

extends State

func update(delta):
	$"../../AudioStreamPlayer".stop()
	$"../../AudioStreamPlayer2".stop()
	if !$"../../AudioStreamPlayer3".playing:
		$"../../AudioStreamPlayer3".play()

	if Global.player.velocity.length() <= 0 or !Input.is_action_pressed("crouch"):
		transition.emit("CrouchingPlayerState")
