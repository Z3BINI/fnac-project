extends Node2D
class_name AbilityManager

@export var spell_spawn_position : Marker2D

@onready var PLAYER_BODY : CharacterBody2D = self.get_parent()

var controller_aim : Vector2
var mouse_aim : Vector2

var ability_one : Spell
var ability_two : Spell

func _process(_delta):
	controller_aim = Input.get_vector("analog_aim_left", "analog_aim_right", "analog_aim_up", "analog_aim_down")
	mouse_aim = (get_global_mouse_position() - spell_spawn_position.global_position).normalized()

func _physics_process(delta):
	# ABILITY TESTING EARLY FASE
	if (Input.is_action_just_pressed("ability_1")):
		ability_one = preload("res://scenes/spells/fire/basic_fire_ball.tscn").instantiate()
		spell_spawn_position.add_child(ability_one)
		toggle_cast_pointer()
	
	if Input.is_action_just_released("ability_1") and ability_one.set_throw == false:
		ability_one.cancel()
		toggle_cast_pointer()
	
	if ability_one:
		if (Input.is_action_just_pressed("throw_cast") and
		!ability_one.set_throw and 
		ability_one.ready_to_throw): 
			
			ability_one.reparent(get_tree().get_first_node_in_group("projectiles"))
			ability_one.dir1 = mouse_aim       # Controller and mouse aim
			ability_one.dir2 = controller_aim  # Seperated TESTING
			
			await ability_one.pre_throw()
			
			ability_one.set_throw = true
			toggle_cast_pointer()

	if (Input.is_action_just_pressed("ability_2")):
		ability_two = preload("res://scenes/spells/water/basic_water_shield.tscn").instantiate()
		PLAYER_BODY.add_child(ability_two)
		
	if Input.is_action_just_released("ability_2"):
		ability_two.cancel()
		
	# ABILITY TESTING EARLY FASE
func toggle_cast_pointer():
	spell_spawn_position.get_child(0).visible = !spell_spawn_position.get_child(0).visible