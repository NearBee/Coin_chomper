extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var visibility_timer = $DialogBox/VisibilityTimer

@export var movement_data : PlayerMovementData
#@export var dialog_box : DialogBox  TO BE WORKED ON SOON

# Get the gravity from the project settings to be synced with RigidBody nodes.
var air_jump = false
var just_wall_jumped = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var coyote_jump_timer = $"Coyote Jump Timer"

func _physics_process(delta):
	var input_axis = Input.get_axis("ui_left", "ui_right")
	
	apply_gravity(delta)
	handle_wall_jump()
	handle_jump()
	handle_acceleration(input_axis, delta)
	handle_air_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	apply_air_resistance(input_axis, delta)
	update_animations(input_axis)
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
	just_wall_jumped = false
		
	if Input.is_action_just_pressed("ui_accept") and movement_data.resource_name != "res://FasterMovementData.tres":		
		movement_data = load("res://FasterMovementData.tres")
		visibility_timer.start()
		#dialog_box.label.set_visible(true)  TO BE WORKED ON SOON
	
		


func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_wall_jump():
	if not is_on_wall_only(): return
		
	var wall_normal = get_wall_normal()
	if Input.is_action_just_pressed("ui_up"):
		velocity.x = wall_normal.x * movement_data.speed
		velocity.y = movement_data.jump_velocity
		just_wall_jumped = true

func handle_jump():
	if is_on_floor(): air_jump = true
	
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = movement_data.jump_velocity
	if not is_on_floor():
		if Input.is_action_just_released("ui_up") and velocity.y < movement_data.jump_velocity / 2:
			velocity.y = movement_data.jump_velocity / 2
			
		if Input.is_action_just_pressed("ui_up") and air_jump and not just_wall_jumped:
			velocity.y = movement_data.jump_velocity
			air_jump = false

func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)
		
func apply_air_resistance(input_axis, delta):
	if input_axis == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resistance * delta)

func handle_acceleration(input_axis, delta):
	if not is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.acceleration * delta)

func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.air_acceleration * delta)

func update_animations(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis > 0)
		animated_sprite_2d.play('walk')
	else:
		animated_sprite_2d.play("idle")
