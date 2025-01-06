extends CharacterBody3D
class_name unknownCreature

var isChasing: bool
var isSearching: bool
var movable : bool

var lastPos
var idleRemainTimer
var innerTimer
var state_machine

#@export var isJumpscare : bool

#point of interest generator
@onready var randomPos = Vector3(randf_range(-95, 100), position.y, randf_range(-95, 95))

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var hasEntered = false
@onready var noiseHeard = false

#@onready var wanderTimer = Difficulty.ucWanderTimer
@onready var wanderTimer = 15.0
#@onready var idleTimerMax = Difficulty.ucIdleTimer
@onready var idleTimerMax = 30
#@onready var idleTimer = Difficulty.ucIdleDiffTimer
@onready var idleTimer = 0
#@onready var idleCycle = Difficulty.ucIdleCycle
@onready var idleCycle = 1
#@onready var walkingSpeed = Difficulty.ucWalkingSpeed
@onready var walkingSpeed = 5
#@onready var chasingSpeed = Difficulty.ucChasingSpeed
@onready var chasingSpeed = 10
@onready var speed
#@onready var chaseTimer = Difficulty.ucChaseTimer
@onready var chaseTimer = 7

#@onready var wanderFail = false
#@onready var wanderFailTimer = 10.0

@onready var nav_agent = $NavigationAgent3D
@onready var anim_tree = $AnimationTree

@onready var hearing = $Ear
@onready var instaDetect = $Instant_Kill_Zone/CollisionShape3D
@onready var jumpscareZone = $Jumpscare_Zone/CollisionShape3D

func _ready():
	#Global reference
	Global.enemy = self
	#Reset Variable
	wandering(0)
	hasEntered = false
	movable = true
	innerTimer = 0
	state_machine = anim_tree.get("parameters/playback")
	isChasing = false
		
func _process(delta):
	#print(isChasing, " isChasing ", chaseTimer , " chaseTimer ",idleTimer , " idleTimer >= idleTimerMax ", innerTimer, " inner Remain Time ")
	
	#Hearing Noise
	if Global.stateCheck._current().name != "RunningPlayerState":
		noiseHeard = false
	else: if Global.stateCheck._current().name == "RunningPlayerState":
		noiseHeard = true
	
	if(hasEntered):
		if(noiseHeard) and $Instant_Ear.has_overlapping_bodies():
			isChasing = true
			#chaseTimer = Difficulty.ucChaseTimer
			chaseTimer = 7.0
	if(chaseTimer <= 0):
		isChasing = false
		anim_tree.set("parameters/conditions/chaseEnd", true)
		
	if isChasing:
		idleTimer = -1.25
		look_at(global_transform.origin, Vector3.UP)
		anim_tree.set("parameters/conditions/scream", isChasing)
		chase()
		speed = chasingSpeed
		chaseTimer -= delta
		#print(chaseTimer)
	else:
		if idleTimer >= idleTimerMax and !isChasing:
			idleRemainTimer = (3.75 * idleCycle) + 3.4
			_idle(delta)
			movable = false
		else: 
			movable = true
			idleTimer += (delta)
			speed = walkingSpeed
			wandering(delta)
		
	#move towards target position
	var direction = nav_agent.get_next_path_position() - global_position
	direction = direction.normalized()
	#speed
	velocity = velocity.lerp(direction * speed, delta * 10)
	
	if movable:
		move_and_slide()
#else:
#	pass
	#anim.play("ArmatureAction_001")

#	timer -= delta
#	var stuck
#	if (timer <= 0):
#		timer = 5
#		stuck = global_position
#	if(wanderFailTimer <= 0):
#		global_position = Vector3(0, 0, 0)
#		global_rotation = Vector3(0, -180, 0)
#	if(global_position == stuck):
#		wanderFailTimer -= delta
#	else:
#		wanderFailTimer = 10.0
	
	#if not isJumpscare:
	#if player.isRunning or gun.justShot:
	#	if gun.justShot:
	#		gun.justShot = false
	#	youreFucked = true
	
	#if isInBiggerDetector and youreFucked:
	#	isChasing = true
	#	youreFucked = false
	#	randomPos = player.global_position 

#chase fucntion
func chase():
	look_at(player.position)
	nav_agent.target_position = player.global_position
	
#wandering logic
func wandering(delta : float) -> void:
	#face to target 
	look_at(global_transform.origin + velocity)
	#change to new target
	nav_agent.target_position = randomPos
	#check if the target is reachable or has reach within area
	if(abs(randomPos.x - global_position.x) <= 15 and abs(randomPos.z - global_position.z) <= 15) or wanderTimer <= 0:
		#generate POI near player
		randomPos = Vector3(randf_range(player.global_position.x - 40, player.global_position.x + 40), position.y, randf_range(player.global_position.z - 20, player.global_position.z + 20))
		#limit value within the game area
		clamp(randomPos.x, -95, 100)
		clamp(randomPos.z, -95, 95)
		#reset wandering time
		wanderTimer = 15.0
	#time ticks every frame
	wanderTimer -= delta
	
func _idle(delta: float) -> void:
	look_at(global_transform.origin, Vector3.UP)
	anim_tree.set("parameters/conditions/idleStart", true)
	anim_tree.set("parameters/conditions/idleEnd", false)
	innerTimer += delta
	if innerTimer >= idleRemainTimer:
		anim_tree.set("parameters/conditions/idleStart", false)
		anim_tree.set("parameters/conditions/idleEnd", true)
		innerTimer = 0
		idleTimer = -1.25

#player has entered the hearing range
func _on_ear_body_entered(body: Node3D):
	if(body.is_in_group("Player")):
		hasEntered = true

#player has left the hearing range
func _on_ear_body_exited(body: Node3D) -> void:
	if(body.is_in_group("Player")):
		hasEntered = false

#unknown creature remembers the player last position
func _on_instant_ear_body_exited(body: Node3D) -> void:
	if(body.is_in_group("Player")):
		lastPos = body.global_position
		randomPos = lastPos
		isChasing = false

#Player death conditions
func _on_death_bubble_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		print("touched")
		#get_tree().change_scene_to_file("res://Scene/DeathScene.tscn")
