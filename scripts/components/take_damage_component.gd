extends Area2D
class_name TakeDamageComponent

@export var HEALTH_COMPONENT : HealthComponent

func can_take_damage() -> bool:  # Checks if we are alive to take the hit
	return (HEALTH_COMPONENT.current_hp > 0)
	
func _on_area_entered(area : DoDamageComponent):
	if can_take_damage():
		HEALTH_COMPONENT.take_damage(area.DAMAGE_AMOUNT)
