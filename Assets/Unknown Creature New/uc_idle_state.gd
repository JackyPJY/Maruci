class_name ucIdleState

extends State

func update(delta):
	if Global.enemy.isChasing:
		transition.emit("CrouchingPlayerState")
