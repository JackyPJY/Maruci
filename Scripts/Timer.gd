extends Panel
class_name deathTimer

var time = Difficulty.deathTimer
#var time = 300
var minutes: int = 0
var seconds: int = 0

signal timeUp

func _process(delta) -> void:
	if !Global.pause:
		if time <= 0:
			emit_signal("timeUp")
		time -= delta
		seconds = fmod(time,60)
		minutes = fmod(time, 3600) / 60
		$Minutes.text = "%02d:" % minutes
		$Seconds.text = "%02d" % seconds
	
func stop() -> void:
	set_process(false)
	
func get_time_formatted() -> String:
	return "%02d:%02d" % [minutes, seconds]

func _on_player_cleared() -> void:
	Global.remainTime = time
	set_process(false)
