extends Resource
class_name a_resource

export var my_color:Color

func _init():
	my_color=Color(randf(),randf(),randf())
