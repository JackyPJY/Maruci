extends Panel

var itemMax : int
var itemCurrent : int

func _ready() -> void:
	$ItemCurrent.text = "0"
	$ItemMax.text = var_to_str(Difficulty.pickUpRequirement)
	#print(itemCurrent, " panel Check")

func update():
	$ItemCurrent.text = var_to_str(itemCurrent)

func _on_player_pick_up_parse(pickUp: Variant) -> void:
	itemCurrent = Global.player.pickUp
	update()
