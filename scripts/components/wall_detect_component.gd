extends Area2D

signal hit_wall

@onready var parent_node = self.get_parent()

func _on_area_entered(_area):
	hit_wall.emit()
