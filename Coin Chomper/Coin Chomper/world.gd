extends Node2D

#Godot has the ability to store @onready keyword
#@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D

# creating a variable of the Collision Polygon
@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D

# creating a variable of the actual polygon that would be in the same shape as
# collision_polygon_2d
@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D


@onready var collision_polygon_2d2 = $StaticBody2D/CollisionPolygon2D2
@onready var polygon_2d2 = $StaticBody2D/CollisionPolygon2D2/Polygon2D


func _ready():
	'''Function thats to be called right as the game is ready to be played'''
	RenderingServer.set_default_clear_color(Color.BLACK)

	polygon_2d.polygon = collision_polygon_2d.polygon
	polygon_2d2.polygon = collision_polygon_2d2.polygon
