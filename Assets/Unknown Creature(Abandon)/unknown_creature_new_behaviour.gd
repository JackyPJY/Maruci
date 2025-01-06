extends CharacterBody3D

var player = null
var state_machine

var isChasing: bool
var isSearching: bool
var hasSeen: bool

var last_seen
var memory_timer = 15.0

@export var player_path : NodePath


@onready var wanderTimer = 60.0
@onready var idleTimer = 10.0
@onready var walkingSpeed = 4
@onready var chasingSpeed = 8
@onready var speed = chasingSpeed
@onready var dead := false

@onready var jumpscare = load("res://Scene/")

@onready var roar

@onready var nav_agent = $NavigationAgent3D
@onready var anim_tree = $AnimationTree

@onready var hearing = $Ear/CollisionShape3D
@onready var instaDetect = $Instant_Kill_Zone/CollisionShape3D
@onready var jumpscareZone = $Jumpscare_Zone/CollisionShape3D

@onready var randomPos = Vector3(randf_range(-75,50),position.y, randf_range(-85,20))

const SPEED = 4.0
const ATTACK_RANGE = 3

func _ready():
	player = get_node(player_path)
	state_machine = anim_tree.get("parameters/playback")

func _physics_process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	match state_machine.get_current_node():
		"Crawling":
			# Navigation
			nav_agent.set_target_position(player.global_transform.origin)
			var next_nav_point = nav_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
			look_at(Vector3(player.global_position.x + velocity.x, global_position.y, player.global_position.z + velocity.z), Vector3.UP)
		"Attack":
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)

	# Conditions
	anim_tree.set("parameters/conditions/attack", _target_in_range())
	anim_tree.set("parameters/conditions/crawl", !_target_in_range())
	
	anim_tree.get("parameters/playback")
	
	move_and_slide()

func _target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE
