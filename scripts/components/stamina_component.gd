extends Node
class_name StaminaComponent

signal stamina_exhausted

@export var MAX_STAMINA : float = 100
@export var RESTORE_CD : float = 4
@export var PUNISH_PAUSE_TIME : float = 1.5

var current_stamina : float
var exhausted : bool 
var punish_reset : bool

func _ready():
	initialize()
	
func _process(delta : float):
	if punish_reset: restore_stamina(delta)

func spending_stamina(delta : float, action_cost : float) -> void:
	current_stamina -= (delta * action_cost)
	if current_stamina <= 0: stamina_exhausted.emit()
	
func spend_stamina(amount : float) -> void:
	current_stamina -= amount
	if current_stamina <= 0: stamina_exhausted.emit()
	
func restore_stamina(delta : float) -> void:
	current_stamina += (delta * (MAX_STAMINA / RESTORE_CD))
	if current_stamina >= MAX_STAMINA:
		initialize()

func _on_stamina_exhausted() -> void:
	exhausted = true
	await get_tree().create_timer(PUNISH_PAUSE_TIME).timeout
	punish_reset = true

func initialize() -> void:
	current_stamina = MAX_STAMINA
	exhausted = false
	punish_reset = false
