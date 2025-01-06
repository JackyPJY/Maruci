extends Interactable

@onready var light = self.get_node(self.get_path_to(self.find_child("OmniLight3D", false, true)))

func _ready() -> void:
	#print(abs(self.global_position.x - Global.player.global_position.x), " object x position with player")
	#print(light, " ", self, " ", light.visible)
	light.visible = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		light.visible = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		light.visible = false
