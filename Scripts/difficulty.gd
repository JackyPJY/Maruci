extends Node

var difficulty : int

var pickUpRequirement : int

var staminaDiffMax : float
var staminaDiffTimer : float
var staminaDiffRegen : float
var deathTimer : float

var ucWanderTimer : float
var ucIdleTimer : float
var ucIdleDiffTimer : float
var ucIdleCycle : float
var ucWalkingSpeed : float
var ucChasingSpeed : float
var ucChaseTimer : float

func _update():
	match difficulty:
		1:
			pickUpRequirement = 5
			staminaDiffMax = 200.0
			staminaDiffTimer = 0
			staminaDiffRegen = 0
			deathTimer = 800

			ucWanderTimer = 25
			ucIdleTimer = 20
			ucIdleDiffTimer = 0
			ucIdleCycle = 3
			ucWalkingSpeed = 5
			ucChasingSpeed = 7
			ucChaseTimer = 5
		2:
			pickUpRequirement = 7
			staminaDiffMax = 100.0
			staminaDiffTimer = 0.5
			staminaDiffRegen = 0.5
			deathTimer = 600

			ucWanderTimer = 20
			ucIdleTimer = 15
			ucIdleCycle = 2
			ucWalkingSpeed = 7
			ucChasingSpeed = 10
			ucChaseTimer = 7
		3:
			pickUpRequirement = 10
			staminaDiffMax = 100.0
			staminaDiffTimer = 1
			staminaDiffRegen = 1
			deathTimer = 300

			ucWanderTimer = 17
			ucIdleTimer = 10
			ucIdleCycle = 1
			ucWalkingSpeed = 10
			ucChasingSpeed = 13
			ucChaseTimer = 10


func _pickedUp() -> void:
	pickUpRequirement -= 1
