extends Node2D
class_name AbilityManager

signal check_spell_button_status(invoked_spell, is_on_cd)

@export var spell_spawn_position : Marker2D
@onready var PLAYER_BODY : CharacterBody2D = self.get_parent()
@onready var hud = $"../HUD"
@onready var player_damage = $"../TakeDamageComponent"


var controller_aim : Vector2
var mouse_aim : Vector2

var fire_spell : Spell = null
var water_spell : Spell = null

var pressed_action : String = ""
var water_action : String = ""
var fire_action : String = ""

var store_water_scale : Vector2 = Vector2.ZERO

func _process(_delta):
	controller_aim = Input.get_vector("analog_aim_left", "analog_aim_right", "analog_aim_up", "analog_aim_down")
	mouse_aim = (get_global_mouse_position() - spell_spawn_position.global_position).normalized()

func _physics_process(delta):
	# ABILITY TESTING EARLY FASE
	
	pressed_action = ""
	
	if (Input.is_action_just_pressed("ability_1")): pressed_action = "ability_1"
	if (Input.is_action_just_pressed("ability_2")): pressed_action = "ability_2"
	if (Input.is_action_just_pressed("ability_3")): pressed_action = "ability_3"
	if (Input.is_action_just_pressed("ability_4")): pressed_action = "ability_4"

	if pressed_action != "": emit_signal("check_spell_button_status", pressed_action, hud.spell_bar.get_spell(pressed_action), hud.spell_bar.check_cd(pressed_action))
	
	
	
	if fire_action != "":
		
		#CANCEL
		if (Input.is_action_just_released(fire_action) and
		fire_action != null and 
		fire_spell.set_throw == false):
			
			hud.toggle_aim_pointer(false)
			fire_spell.cancel()
			
			fire_action = ""
			fire_spell = null
		
		#THROW
		if (Input.is_action_just_pressed("throw_cast") and
		spell_spawn_position.get_child_count() != 0): 
			
			var store_action = fire_action  # Prevent click spam crash
			fire_action = ""
			
			if fire_spell != null:
				fire_spell.reparent(get_tree().get_first_node_in_group("projectiles"))
				fire_spell.dir1 = mouse_aim       # Controller and mouse aim
				fire_spell.dir2 = controller_aim  # Seperated TESTING
			
				fire_spell.pre_throw()
			
				hud.spell_bar.used_spell(store_action)
				
				hud.toggle_aim_pointer(false)
				
				fire_spell = null

	if water_action != "":
		player_damage.toggle_take_damage_disabled(true)
		
		if (store_water_scale != Vector2.ZERO 
		and water_spell.active == false):  # Get last used shield size
			water_spell.scale = store_water_scale
			
		water_spell.active = true
		
		if water_spell.scale <= Vector2.ZERO: 
			store_water_scale = Vector2.ZERO  # Reset stored size
			water_spell.cancel()
			hud.spell_bar.used_spell(water_action)
			water_action = ""
			water_spell = null
		
			
		#CANCEL
		if (Input.is_action_just_released(water_action)):
			store_water_scale = water_spell.scale  # Store current size
			water_spell.cancel()
			water_action = ""
			water_spell = null
				
	else:
		player_damage.toggle_take_damage_disabled(false)

func _on_check_spell_button_status(pressed_action, invoked_spell, is_on_cd):
	if invoked_spell == null:
		print("No spell on that button!")
		return
	
	if is_on_cd: 
		print("Ability on cooldown...")
		return
		
	match (invoked_spell.SPELL_TYPE):
		"THROWABLE":
			fire_action = pressed_action
			spell_spawn_position.add_child(invoked_spell)
			hud.toggle_aim_pointer(true)
			fire_spell = invoked_spell
			
		"SELF_INFLICTING":
			water_action = pressed_action
			PLAYER_BODY.add_child(invoked_spell)
			water_spell = invoked_spell


