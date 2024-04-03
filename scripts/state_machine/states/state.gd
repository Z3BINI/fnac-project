extends Node
class_name State

@export var self_body : CharacterBody2D
@export var animation_player : AnimationPlayer

signal state_changed

func enter_state(player_body : Player = null):
	pass
	
func exit_state():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	pass
