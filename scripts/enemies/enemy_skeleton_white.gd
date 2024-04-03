extends CharacterBody2D

var current_direction : Vector2
var current_speed : float 
var current_accel : float

# Called when the node enters the scene tree for the first time.
func _ready():
	# TEMPORARY HP UI LOGIC
	$TemporaryHP.max_value = $HealthComponent.MAX_HP


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if velocity != Vector2.ZERO: 
		$Sprite2D.flip_h = (velocity.x < 0)
	
	# Temporary logic for flipping damage box with this sprite
	if ($Sprite2D.flip_h): $DoDamageComponent.rotation_degrees = 180
	else: $DoDamageComponent.rotation_degrees = 0
	
	
	# TEMPORARY HP UI LOGIC
	$TemporaryHP.value = $HealthComponent.current_hp

func _physics_process(_delta):
	velocity = velocity.move_toward(current_direction * current_speed, current_accel)
	move_and_slide()
