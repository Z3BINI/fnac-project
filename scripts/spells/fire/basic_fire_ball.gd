extends Spell

@onready var do_damage_component = $DoDamageComponent
@onready var animation_player = $AnimationPlayer

var dir1 : Vector2  # Mouse
var dir2 : Vector2  # Controller

func _ready():
	channel()
	
func _physics_process(delta):
	if ready_to_throw and set_throw:
		do_damage_component.toggle_detection_disabled(false)
		throw(delta)

func channel():
	animation_player.play("spawn")
	await animation_player.animation_finished
	ready_to_throw = true
	animation_player.play("idle")
	
func cancel():
	$PointLight2D.enabled = false
	animation_player.play("impact")
	await animation_player.animation_finished
	queue_free()

func throw(delta):
	animation_player.play("throw")
	global_position += dir1 * delta * TRAVEL_SPEED	

func pre_throw():
	rotation_degrees = rotate_towards_vector(dir1)  # Specificly situated here due to sprite in question
	animation_player.play("pre_throw")
	await animation_player.animation_finished
	set_throw = true

func _on_do_damage_component_did_damage():
	set_throw = false
	cancel()

func _on_wall_detect_component_hit_wall():
	set_throw = false
	cancel()

func rotate_towards_vector(normalized_direction: Vector2):
	# Calculate the angle between the normalized direction and the positive x-axis
	var angle = atan2(normalized_direction.y, normalized_direction.x)
	# Convert the angle to degrees and rotate the Node2D
	return angle * 180 / PI
	
