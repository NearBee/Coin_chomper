extends Control

@onready var timer = $VisibilityTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	# Start the animation when the dialog box appears
	animate_in()
	animate_out()
	

func animate_in():
	var tween = get_tree().create_tween()
	tween.interpolate_value(self, 0.0, 1.0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	# Start the tiemr to close the dialog box after 2 seconds
	$Timer.start()

func animate_out():
	var tween = get_tree().create_tween()
	tween.interpolate_value(self, 1.0, 0.0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	# Disconnect signals and clean up resources
	$Timer.stop()
	$Timer.disconnect('timeout', timer)
	

func _on_Timer_timeout():
	animate_out()
