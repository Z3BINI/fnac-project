extends Node
class_name HealthComponent

signal died

@export var MAX_HP : float = 100

var current_hp : float

func _ready() -> void:
	initialize()

func heal(heal_amount : float) -> void:
	current_hp += heal_amount
	if current_hp > MAX_HP: current_hp = MAX_HP

func take_damage(damage_amount : float) -> void: 
	current_hp -= damage_amount
	
	if current_hp <= 0:
		died.emit()

func initialize() -> void:
	current_hp = MAX_HP
