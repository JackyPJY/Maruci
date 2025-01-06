extends CharacterBody3D

var staminaB = 200
var can_regen = false
var can_start_timer = true
var time_to_wait
var s_timer = 0
var regen_value
#var staminaMax = Difficulty.staminaDiffMax
var staminaMax = 100
var regenDiffValue = Difficulty.staminaDiffRegen
var staminaDiffTimer = Difficulty.staminaDiffTimer

var speed = 0.0
const CROUCH_SPEED = 2.5
const WALK_SPEED = 7.0
const SPRINT_SPEED = 13.0
const SENSITIVITY = 0.003

const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

var pickUp

const BASE_FOV = 75.0
const FOV_CHANGE = 1

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var hitbox = $CollisionShape3D
@onready var mouse_mode = false
@onready var stamina = $Control/ProgressBar
@onready var deathTimer = $Timer

signal pickUpParse(pickUp)
signal cleared
signal paused(bool)

# Mouse Cursor Disabled
func _ready():
	#Set global reference to self in Global Singleton
	Global.player = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#Set stamina to max value at launch
	stamina.max_value = staminaMax
	stamina.value = staminaMax
	pickUp = 0
	
# Camera Control
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	if pickUp == Difficulty.pickUpRequirement:
		emit_signal("cleared")
	# Add the gravity.
	velocity += get_gravity() * delta
		
	if Global.stateCheck._current().name == "IdlePlayerState":
		time_to_wait = 1.0 + staminaDiffTimer
		regen_value = 3.0 - regenDiffValue
	if Global.stateCheck._current().name == "WalkingPlayerState":
		time_to_wait = 2.5 + staminaDiffTimer
		regen_value = 1.0 - regenDiffValue
	if Global.stateCheck._current().name == "CrouchingPlayerState":
		time_to_wait = 2.0 + staminaDiffTimer
		regen_value = 2.0 - regenDiffValue
	
	if Input.is_action_just_pressed("Map"):
		$Map.visible = !$Map.visible
		
	if !$PauseUI.visible:
		$PauseUI/Pause_Main_Menu.visible = true
		$PauseUI/Sound_Settings.visible = false

	if Input.is_action_just_pressed("Pause"):
		emit_signal("paused", true)

	#print (stamina.value, " stamina ", var_to_str(time_to_wait), " timer ", regen_value, " regen value ", Global.stateCheck._current(), " state")
	#print(Difficulty.staminaDiffMax)
	_stamina_manager(delta)
	staminaBar(delta)

	if Input.is_action_pressed("sprint") and Global.stateCheck._current().name != "CrouchingPlayerState":
		can_regen = false
		if stamina.value >= 0:
			can_regen = false
			speed = SPRINT_SPEED
			stamina.value -= .2
			s_timer = 0
		if stamina.value <= 0:
			speed = WALK_SPEED
	else: if Input.is_action_pressed("crouch"):
		speed = CROUCH_SPEED
		head.position.y = 0.55
		hitbox.scale = Vector3(0.5,.5,.5)
	else:
		speed = WALK_SPEED
		head.position.y = 1
		hitbox.scale = Vector3(.5,.9,.5)
	
	# Get the input direction and handle the movement/decelerartion
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0.0
		velocity.z = 0.0
	
	# Head Bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	#FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2.5)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	move_and_slide()
	
	#print(stamina, "\n")
		
func _headbob(time) -> Vector3:
		var pos = Vector3.ZERO
		pos.y = sin(time * BOB_FREQ) * BOB_AMP
		pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
		return pos

func _stamina_manager(delta):
	if !can_regen && stamina.value != staminaMax or stamina.value == 0:
		can_start_timer = true
		if can_start_timer:
			s_timer += delta
			if s_timer >= time_to_wait:
				can_regen = true
				can_start_timer = false
				s_timer = 0
				
	if stamina.value >= staminaMax:
		can_regen = false
		
	if can_regen == true:
		stamina.value += regen_value
		can_start_timer = false
		s_timer = 0

func staminaBar(delta) -> void:
	if stamina.value <= 75:
		stamina.visible = true
	#	if stamina.modulate.a >= 0 and stamina.modulate.a < 0.75:
	#		stamina.modulate.a += 0.002
	#if stamina.modulate.a >= 0.75:
	#	stamina.modulate.a -= 0.002
	if stamina.value >= 100:
		stamina.visible = false


func _on_panel_time_up() -> void:
	get_tree().change_scene_to_file("res://Scene/DeathScene.tscn")
	pass

func _on_interact_ray_picked_up(itemPicked: Variant) -> void:
	$AudioStreamPlayer4.play()
	pickUp += itemPicked
	emit_signal("pickUpParse", pickUp)

func _on_finish_line_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		$Control2.visible = true
		$AnimationPlayer.play("WhiteScreen")
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://Scene/end_game.tscn")
