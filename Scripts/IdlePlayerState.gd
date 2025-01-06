class_name IdlePlayerState

extends State

func update(delta):
	$"../../AudioStreamPlayer".stop()
	$"../../AudioStreamPlayer2".stop()
	$"../../AudioStreamPlayer3".stop()
	
	if Global.player.velocity.length() >= 2.5 or Input.is_action_pressed("crouch"):
		transition.emit("CrouchingPlayerState")

	if Global.player.velocity.length() >= 7.0 or (Input.is_action_pressed("backward") or Input.is_action_pressed("forward") or Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		transition.emit("WalkingPlayerState")
