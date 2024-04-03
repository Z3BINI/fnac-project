extends Area2D
class_name TakeDamageComponent

signal knock_back(direction : Vector2)

@onready var collider = self.get_child(0)

@export var HEALTH_COMPONENT : HealthComponent

func can_take_damage() -> bool:  # Checks if we are alive to take the hit
	return (HEALTH_COMPONENT.current_hp > 0)
	
func _on_area_entered(area : DoDamageComponent):
	if (can_take_damage() and 
	(area.get_parent().name != get_parent().name) and 
	!(area.get_parent().is_in_group("player_ability") and get_parent().is_in_group("player"))):
		HEALTH_COMPONENT.take_damage(area.DAMAGE_AMOUNT)
		knock_back.emit((global_position - area.global_position).normalized())

func toggle_take_damage_disabled(state):
	collider.disabled = state
