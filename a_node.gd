extends Node2D

var savedata:InternalState # setget ,get_savedata

func _ready():
	print("ready")
	if savedata == null:
		savedata=InternalState.new()
		savedata.my_color=Color(randf(),randf(),randf())
	$Sprite.modulate=savedata.my_color

func get_savedata()->SaveEntityResource:
	var my_savedata=SaveEntityResource.new()
	my_savedata.prefab=filename
	my_savedata.state=savedata
	print(my_savedata)
	return my_savedata

func load_savedata(savedata:InternalState):
	self.savedata=savedata

class InternalState extends Resource:
	export var my_color:Color
