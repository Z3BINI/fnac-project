extends Spell

@export var REDUCER : float = 0.15

var active : bool = false
var store_scale : Vector2 = Vector2.ZERO

func _ready():
	$TakeDamageComponent.HEALTH_COMPONENT = $HealthComponent  # Wasnt auto loading on instances

func _physics_process(delta):
	if active == true:
		scale -= Vector2(REDUCER, REDUCER) * delta
		
func cast():
	pass
	
func cancel():
	active = false
	queue_free()

func _on_health_component_took_damage():
	scale -= Vector2(0.3, 0.3)
