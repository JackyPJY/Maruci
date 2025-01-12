extends Node3D

#https://docs.godotengine.org/en/stable/tutorials/math/random_number_generation.html#better-randomness-using-shuffle-bags
var _areas = [1,2,3,4,5]
var _areas2 = [6,7,8,9,10]
var _areas3 = [11,12,13,14,15]
var _areas4 = [16,17,18,19,20]
var _areas5 = [21,22,23,24,25]
# A copy of the fruits array so we can restore the original value into `fruits`.
var _areas_full = []
var _areas_final = []

var importItems = []

var remain = Difficulty.pickUpRequirement

var played 

func _ready():
	played = false 
	for i in 2:
		_areas_full.append(get_random(_areas)) 
		_areas_full.append(get_random(_areas2)) 
		_areas_full.append(get_random(_areas3)) 
		_areas_full.append(get_random(_areas4)) 
		_areas_full.append(get_random(_areas5)) 
	
	for i in 5:
		_areas_final.append(_areas_full[0])
		_areas_full.pop_front()
		
	_areas_full.shuffle()
	
	for i in _areas_full.size():
		_areas_final.append(_areas_full[i])
	
	importItems.fill(null)

	for i in $Collectable.get_children():
		importItems.append(i.get_path())
	
	for i in $Collectable.get_children():
		importItems.append(i.get_path())

	for i in remain:
		print(_areas_final[0])
		var item = load("res://Assets/propsv2/scroll2_interactable.scn").instantiate()
		var temp = _areas_final[0]
		match temp:
			1:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			2:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			3:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			4:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			5:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			6:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			7:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			8:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			9:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			10:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			11:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			12:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			13:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			14:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			15:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			16:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			17:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			18:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			19:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			20:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			21:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			22:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			23:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			24:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
			25:
				get_node(importItems[temp - 1]).add_child(item)
				_areas_final.pop_front()
				pass
		

func get_random(_areas):
	_areas.shuffle()
	var random_area = _areas.pop_front()
	# Prints "apple", "orange", "pear", or "banana" every time the code runs.
	return random_area

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_process(false)

func _on_player_cleared() -> void:
	if !played:
		$AudioStreamPlayer5.play()
		played = true
	$Node3D/DoorSimple.hide()
	$Node3D/DoorSimple/StaticBody3D/CollisionShape3D.disabled = true
