extends State
class_name Attack

@export var ATTACK_CD : float = 1

var attack_counter : int = 0

func enter_state(player_body : Player = null):
	self_body.current_speed = 0.0
	
	
	match(attack_counter):
		0:
			animation_player.play("attack_1")
			await animation_player.animation_finished
			attack_counter += 1
		1:
			animation_player.play("attack_2")
			await animation_player.animation_finished
			attack_counter += 1
		2:
			animation_player.play("attack_1")
			await animation_player.animation_finished
			animation_player.play("attack_2")
			await animation_player.animation_finished
			attack_counter = 0
	
	
	animation_player.play("idle")
	
	await get_tree().create_timer(ATTACK_CD).timeout
	state_changed.emit(self, 'hostile', player_body)
	
func exit_state():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	pass

