extends Node2D

var savedata:SaveData # setget ,get_savedata

func _ready():
	print("ready")
	if savedata == null:
		savedata=SaveData.new()
		savedata.my_color=Color(randf(),randf(),randf())
	$Sprite.modulate=savedata.my_color

func get_savedata()->SaveEntityResource:
	var data=SaveEntityResource.new()
	data.set_data(self,savedata)
	#data.entity=filename
	#data.state=savedata
	return data

func load_savedata(savedata:SaveData):
	self.savedata=savedata

class SaveData extends Resource:
	export var my_color:Color
