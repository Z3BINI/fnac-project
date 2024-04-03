extends State
class_name  Idle

@export var MIN_IDLE_TIME : float = 5
@export var MAX_IDLE_TIME : float = 10


var idle_time : float

func randomize_idle_time():
	idle_time = randf_range(MIN_IDLE_TIME, MAX_IDLE_TIME)

func enter_state(player_body : Player = null):
	randomize_idle_time()
	if self_body:
		self_body.current_speed = 0.0
		self_body.current_direction = Vector2.ZERO
		
		animation_player.play("idle")

func update(delta):
	#if self_body.player_in_range and !self_body.PLAYER.dead:
		#state_changed.emit(self, 'hostile')
	
	if idle_time > 0:
		idle_time -= delta
	else:
		state_changed.emit(self, 'roam', null)

func _on_player_detection_body_entered(body):
	state_changed.emit(self, 'hostile', body)
