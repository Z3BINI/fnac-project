extends CharacterBody2D
class_name Player

var input_direction : Vector2
var is_pressing_sprint : bool
var pressed_dash : bool

func _process(_delta) -> void:
	# Movement input handling 
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	is_pressing_sprint = Input.is_action_pressed("sprint")
	if (Input.is_action_just_pressed("dash")): pressed_dash = true  # Toggle dash request
	
func _on_health_component_took_damage():
	print("player took dmg")
