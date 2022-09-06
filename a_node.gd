extends Node2D

var _save_params={} setget ,get_save_params


func _ready():
	randomize()
	print("ready")
	$Sprite.modulate=Color(randf(),randf(),randf())

func get_savedata():
	pass

func get_save_params():
	_save_params={}
	_save_params["position"]=self.position
	_save_params["color"]=$Sprite.modulate
	return _save_params
