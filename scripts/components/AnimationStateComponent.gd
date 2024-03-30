extends AnimationTree

@onready var BODY : CharacterBody2D = self.get_parent()

func _physics_process(_delta):
	
	if BODY.velocity == Vector2.ZERO:
		self["parameters/conditions/is_idle"] = true
		self["parameters/conditions/is_walking"] = false
	else:
		self["parameters/conditions/is_idle"] = false
		self["parameters/conditions/is_walking"] = true
	
	if BODY.input_direction != Vector2.ZERO:
		self["parameters/idle/blend_position"] = BODY.input_direction
		self["parameters/walk/blend_position"] = BODY.input_direction
