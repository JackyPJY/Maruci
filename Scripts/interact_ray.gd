extends RayCast3D

@onready var hand_visible = $Hand
@onready var interact_key = $Prompt

signal pickedUp(itemPicked)

func _physics_process(_delta):
	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable:
			interact_key.text = collider.get_prompt()
			hand_visible.visible = true
			interact_key.visible = true
			
			if Input.is_action_just_pressed(collider.prompt_input):
				collider.interact(owner)
				emit_signal("pickedUp", 1)
			
	else:
		hand_visible.visible = false
		interact_key.visible = false
