extends Node2D
class_name Spell

@export_enum('THROWABLE', 'SELF_INFLICTING') var SPELL_TYPE : String

@export var CAST_TIME : float
@export var MANA_COST : float
@export var COOLDOWN : float
@export var TEXTURE : Texture2D
@export var TRAVEL_SPEED : float

var player : CharacterBody2D

var ready_to_throw : bool = false
var set_throw : bool = false

func channel():
	pass

func cast():
	pass
	
func cancel():
	pass

func throw(delta : float): 
	pass

