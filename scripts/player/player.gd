extends CharacterBody2D
class_name Player

@onready var cast_pos = $CastPos

var input_direction : Vector2
var controller_aim : Vector2
var mouse_aim : Vector2
var is_pressing_sprint : bool
var pressed_dash : bool

var ability_one : Spell

func _process(_delta) -> void:
	# Input handling 
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	is_pressing_sprint = Input.is_action_pressed("sprint")
	if (Input.is_action_just_pressed("dash")): pressed_dash = true  # Toggle dash request
	
	controller_aim = Input.get_vector("analog_aim_left", "analog_aim_right", "analog_aim_up", "analog_aim_down")
	mouse_aim = (get_global_mouse_position() - $CastPos.global_position).normalized()
	

func _physics_process(_delta) -> void:
		# ABILITY TESTING EARLY FASE
	if (Input.is_action_just_pressed("ability_1")):
		ability_one = preload("res://scenes/spells/fire/basic_fire_ball.tscn").instantiate()
		cast_pos.add_child(ability_one)
	
	if Input.is_action_just_released("ability_1") and ability_one.set_throw == false:
		ability_one.cancel()
	
	if ability_one:
		if (Input.is_action_just_pressed("throw_cast") and
		!ability_one.set_throw and 
		ability_one.ready_to_throw): 
			
			ability_one.reparent(get_tree().get_first_node_in_group("projectiles"))
			ability_one.dir1 = mouse_aim       # Controller and mouse aim
			ability_one.dir2 = controller_aim  # Seperated TESTING
			
			await ability_one.pre_throw()
			
			ability_one.set_throw = true
	
	# ABILITY TESTING EARLY FASE

