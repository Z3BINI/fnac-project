extends Area2D
class_name DoDamageComponent

signal did_damage

@export var DAMAGE_AMOUNT : float

func _on_area_entered(area : HealthComponent):
	area.take_damage(DAMAGE_AMOUNT)
	did_damage.emit()

func toggle_detection_disabled(state : bool):
	get_child(0).disabled = state
