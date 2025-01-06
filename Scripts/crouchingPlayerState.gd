class_name CrouchingPlayerState

extends State

func update(delta):
	$"../../AudioStreamPlayer".stop()
	$"../../AudioStreamPlayer2".stop()
	$"../../AudioStreamPlayer3".stop()
	
	if Global.player.velocity.length() == 0.0 and !Input.is_action_pressed("crouch"):
		transition.emit("IdlePlayerState")
		
	if Global.player.velocity.length() >= 2.5 and Input.is_action_pressed("crouch") and (Input.is_action_pressed("backward") or Input.is_action_pressed("forward") or Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		transition.emit("CrouchWalkingPlayerState")
	
	if Global.player.velocity.length() >= 7.0:
		transition.emit("WalkingPlayerState")	
