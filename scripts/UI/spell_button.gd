extends TextureButton

@onready var cooldown = $Cooldown
@onready var key = $Key
@onready var time = $Time
@onready var timer = $Timer

var spell : Spell = null

var change_key = "":
	set(value):
		change_key = value
		key.text = value
		
		shortcut = Shortcut.new()
		var new_key = InputEventKey.new()
		new_key.keycode = value.unicode_at(0)
		
		shortcut.events = [new_key]

func _ready():
	change_key = "Q"
	cooldown.max_value = timer.wait_time
	set_process(false)

func _process(_delta):
	time.text = "%3.1f" % timer.time_left
	cooldown.value = timer.time_left


func _on_pressed():
	if spell != null:
		spell.cast()
		
		timer.start()
		disabled = true
		set_process(true)


func _on_timer_timeout():
	disabled = false
	time.text = ""
	cooldown.value = 0
	set_process(false)
