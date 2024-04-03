extends State
class_name Roam

@export var ROAM_SPEED : float = 10
@export var ROAM_ACCELERATION : float = 5
@export var MIN_ROAM_TIME : float = 1
@export var MAX_ROAM_TIME : float = 4

var random_direction : Vector2
var roam_time : float

func randomize_roam_time():
	roam_time = randf_range(MIN_ROAM_TIME, MAX_ROAM_TIME)

func randomize_roam_dir():
	random_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func enter_state(player_body : Player = null):
	randomize_roam_time()
	randomize_roam_dir()
	
	if self_body:
		self_body.current_direction = random_direction
		self_body.current_speed = ROAM_SPEED
		self_body.current_accel = ROAM_ACCELERATION
		
		animation_player.play("walk")

func update(delta):
	#if self_body.player_in_range and !self_body.PLAYER.dead:
		#state_changed.emit(self, 'hostile')
	
	if roam_time > 0:
		roam_time -= delta
	else:
		state_changed.emit(self, 'idle', null)

func physics_update(_delta):
	pass
	#if self_body.is_on_wall():  # Move away from walls
		 #= self_body.get_wall_normal()

func _on_player_detection_body_entered(body):
	state_changed.emit(self, 'hostile', body)
