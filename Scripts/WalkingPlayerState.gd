class_name WalkingPlayerState

extends State

func update(delta):
	$"../../AudioStreamPlayer2".stop()
	$"../../AudioStreamPlayer3".stop()
	if !$"../../AudioStreamPlayer".playing:
		$"../../AudioStreamPlayer".play()
		
	if Global.player.velocity.length() == 0.0 and !(Input.is_action_pressed("backward") or Input.is_action_pressed("forward") or Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		transition.emit("IdlePlayerState")
	
	if Global.player.velocity.length() >= 2.5 and Global.player.velocity.length() < 15.0 and Input.is_action_pressed("crouch"):
		transition.emit("CrouchingPlayerState")
	
	if Global.player.velocity.length() >= 13.0 and Input.is_action_pressed("sprint"):
		transition.emit("RunningPlayerState")
