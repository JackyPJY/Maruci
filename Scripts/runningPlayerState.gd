class_name RunningPlayerState

extends State

signal runningPlayer

func update(delta):
	
	if Input.is_action_pressed("sprint"):
		$"../../AudioStreamPlayer".stop()
		$"../../AudioStreamPlayer3".stop()
	if !$"../../AudioStreamPlayer2".playing:
		$"../../AudioStreamPlayer2".play()
	
	emit_signal("runningPlayer")
	if Global.player.velocity.length() == 0.0:
		transition.emit("IdlePlayerState")
	
	if Global.player.velocity.length() < 10.0:
		transition.emit("WalkingPlayerState")
