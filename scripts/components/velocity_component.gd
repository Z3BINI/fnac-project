extends Node
class_name VelocityComponent

signal dashed

@onready var MY_BODY : CharacterBody2D = self.get_parent()

@export var stamina_component : StaminaComponent

@export var WALK_SPEED : float = 125
@export var SPRINT_SPEED : float = 250
@export var ACCELERATION : float = 10
@export var DASH_STRENGTH : float = 500

# Stamina action cost menu
@export var SPRINT_COST : float = 20
@export var DASH_COST : float = 40

var current_speed : float

func _ready():
	current_speed = WALK_SPEED

func _physics_process(delta):
	# Sprint/walk/dash velocity&stamina handling
	if (!stamina_component.exhausted and                                    # If NOT exhausted AND
	((MY_BODY.pressed_dash and MY_BODY.input_direction != Vector2.ZERO) or  # dashing with defined direction OR
	(MY_BODY.is_pressing_sprint and MY_BODY.velocity != Vector2.ZERO))):    # sprinting with defined direction

		if (MY_BODY.is_pressing_sprint): set_sprinting(delta)
		if (MY_BODY.pressed_dash): dash()
	
	else:  # Otherwise is idle OR walking (both replenish stamina)
		
		set_resting(delta)
	
	MY_BODY.velocity = MY_BODY.velocity.move_toward(MY_BODY.input_direction * current_speed, ACCELERATION)
	MY_BODY.move_and_slide()
	
func dash():
	MY_BODY.pressed_dash = false  # Toggle dash request
	dashed.emit()
	MY_BODY.velocity += MY_BODY.input_direction * DASH_STRENGTH
	stamina_component.spend_stamina(DASH_COST)
	
func set_sprinting(delta : float):
	current_speed = SPRINT_SPEED
	stamina_component.spending_stamina(delta, SPRINT_COST)

func set_resting(delta : float):
	MY_BODY.pressed_dash = false  # To ignore dashes done while exhausted
	current_speed = WALK_SPEED
	if (!stamina_component.exhausted and 
	stamina_component.current_stamina < stamina_component.MAX_STAMINA): 
		stamina_component.restore_stamina(delta)
