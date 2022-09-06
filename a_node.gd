extends Node2D

var _save_params={} setget ,get_save_params
onready var my_resource:a_resource=null

func _ready():
	print("ready")
	if my_resource == null:
		my_resource=a_resource.new()
		
	$Sprite.modulate=my_resource.my_color

func get_savedata():
	pass

func get_save_params():
	_save_params={}
	_save_params["position"]=self.position
	_save_params["color"]=$Sprite.modulate
	return _save_params
