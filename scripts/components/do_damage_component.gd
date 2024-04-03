extends Area2D
class_name DoDamageComponent

signal did_damage

@export var DAMAGE_AMOUNT : float

func _on_area_entered(area):
	if ((area.get_parent().name != get_parent().name) and 
	!(get_parent().is_in_group("player_ability") and area.get_parent().is_in_group("player"))):
		did_damage.emit()

func toggle_detection_disabled(state : bool):
	get_child(0).disabled = state
