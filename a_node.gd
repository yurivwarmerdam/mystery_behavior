extends Node2D

var savedata:SaveData # setget ,get_savedata

func _ready():
	print("ready")
	if savedata == null:
		savedata=SaveData.new()
		savedata.my_color=Color(randf(),randf(),randf())
	$Sprite.modulate=savedata.my_color

func get_savedata()->SaveData:
	var savedata=SaveEntityResource.new()
	savedata.entity=self
	savedata.state=savedata
	return savedata

func load_savedata(savedata:SaveData):
	self.savedata=savedata


class SaveData extends Resource:
	var my_color:Color
