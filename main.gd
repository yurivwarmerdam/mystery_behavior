extends Node

onready var my_resource=preload("res://new_atlastexture.tres")

var simple_save_path="res://saves/simple_save.tres"
var simple_resource:SimpleResource
var savegame="res://new_atlastexture.tres"

func _ready():
	$CanvasLayer/buttons/save.connect("button_down",self,"save_btn")
	$CanvasLayer/buttons/load.connect("button_down",self,"load_btn")

var indexes=[
	Rect2(0,0,32,32),
	Rect2(32,0,32,32),
	Rect2(0,32,32,32),
	Rect2(32,32,32,32),
	]

var index=0

func _unhandled_input(event):
	if event is InputEventMouseButton && event.pressed:
		index+=1
		my_resource.region=indexes[index%indexes.size()]


func save_btn():
	ResourceSaver.save(savegame,my_resource)
	pass

func load_btn():
	#my_resource.take_over_path(savegame)
	print("asd")
	my_resource=ResourceLoader.load(savegame,"",true)
	my_resource.emit_changed()
	pass

