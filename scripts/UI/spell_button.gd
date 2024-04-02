extends TextureButton

@onready var cooldown_texture = $Cooldown
@onready var time = $Time
@onready var timer = $Timer
@onready var key = $Key

var spell : Spell = null

var on_cd : bool = false

func _ready():
	if spell != null:
		set_spell_stats()

func set_spell_stats():
	timer.wait_time = spell.COOLDOWN
	time.text = str(spell.COOLDOWN)
	
	texture_normal = spell.TEXTURE
	
	cooldown_texture.max_value = timer.wait_time
	cooldown_texture.value = 0
	set_process(false)

func _process(_delta):
	time.text = "%3.1f" % timer.time_left
	cooldown_texture.value = timer.time_left

func used_spell():
	on_cd = true
	timer.start()
	set_process(true)

func _on_timer_timeout():
	on_cd = false
	set_spell_stats()
	set_process(false)
