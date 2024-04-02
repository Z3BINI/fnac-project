extends HBoxContainer

var spell_bar : Dictionary

var ability_one : Spell = preload("res://scenes/spells/water/basic_water_shield.tscn").instantiate()
var ability_two : Spell = preload("res://scenes/spells/fire/basic_fire_ball.tscn").instantiate()

func _ready():
	spell_bar["ability_1"] = $SpellButton
	spell_bar["ability_2"] = $SpellButton2
	spell_bar["ability_3"] = $SpellButton3
	spell_bar["ability_4"] = $SpellButton4

	spell_bar["ability_1"].key.text = "Q"
	spell_bar["ability_2"].key.text = "E"
	spell_bar["ability_3"].key.text = "R"
	spell_bar["ability_4"].key.text = "V"
	
	spell_bar["ability_1"].spell = ability_two
	spell_bar["ability_1"].set_spell_stats()
	
	spell_bar["ability_2"].spell = ability_one
	spell_bar["ability_2"].set_spell_stats()
	
	
	
func check_cd(ability : String):
	return spell_bar[ability].on_cd	
	
func change_spell(ability : String, new_spell : Spell):
	spell_bar[ability].spell = new_spell
	spell_bar[ability].set_spell_stats()

func used_spell(ability : String):
	spell_bar[ability].used_spell()

func get_spell(ability : String):
	if spell_bar[ability].spell != null:
		return (spell_bar[ability].spell).duplicate()
