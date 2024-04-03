extends State
class_name Hostile

@export var CHASE_SPEED : float = 20
@export var CHASE_ACCELERATION : float = 10

var player : Player
var chase_direction : Vector2
var distance_to_player : float
var has_attacked : bool = false

func enter_state(player_body : Player = null):
	if player_body != null:
		player = player_body
		
	if self_body:
		self_body.current_speed = CHASE_SPEED
		self_body.current_accel = CHASE_ACCELERATION
		
		animation_player.play("walk")
	
func update(delta):
	pass

func physics_update(_delta):
	distance_to_player = (player.global_position - self_body.global_position).length()
	chase_direction = (player.global_position - self_body.global_position).normalized()
	
	if distance_to_player <= 60:
		state_changed.emit(self, 'attack', player)
	self_body.current_direction = chase_direction

func _on_player_detection_body_exited(body):
	state_changed.emit(self, 'roam', null)
