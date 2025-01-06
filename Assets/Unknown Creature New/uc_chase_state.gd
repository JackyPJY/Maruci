class_name ucChaseState

extends State

func update(delta):
	if !Global.enemy.isChasing:
		transition.emit("CrouchingPlayerState")
