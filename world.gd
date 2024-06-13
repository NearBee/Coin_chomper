extends Node2D

#Godot has the ability to store @onready keyword
#@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D

@export var next_level : PackedScene

@onready var level_completed = $CanvasLayer/LevelCompleted


func _ready():
	'''Function thats to be called right as the game is ready to be played'''
	RenderingServer.set_default_clear_color(Color.BLACK)
	
	Events.level_completed.connect(show_level_completed)
	# Connecting of 'level_completed' to the show_level_completed() function
	# in .Events
	
func show_level_completed():
	level_completed.show()
	get_tree().paused = true
	
	if not next_level is PackedScene: 
		return
	await LevelTransition.fade_to_black()
		
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)
	await LevelTransition.fade_from_black()
