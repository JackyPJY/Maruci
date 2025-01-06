class_name ucPatrolState

extends State

func update(delta):
	if Global.enemy.isChasing:
		transition.emit("CrouchingPlayerState")
