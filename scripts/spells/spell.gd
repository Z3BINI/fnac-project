extends Node2D
class_name Spell

@export var CAST_TIME : float
@export var MANA_COST : float
@export var THROW_SPEED : float

var set_throw : bool = false
var ready_to_throw : bool = false

func channel():
	pass
	
func cancel():
	pass

func throw(delta : float): 
	pass
