extends Area2D

@onready var parent_node = self.get_parent()

func _on_area_entered(_area):
	# Any animation for destruction goes here...
	parent_node.queue_free()
