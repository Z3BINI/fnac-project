extends CanvasLayer
class_name HUD

@export var stamina_component : StaminaComponent
@export var health_component : HealthComponent

@onready var health = $Health
@onready var stamina = $Stamina

func _ready():
	health.max_value = health_component.MAX_HP
	stamina.max_value = stamina_component.MAX_STAMINA

func _process(_delta):
	stamina.value = stamina_component.current_stamina
	health.value = health_component.current_hp
