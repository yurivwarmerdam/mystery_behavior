extends Node

onready var a_node=preload("res://a_node.tscn")
onready var save_button := $a_button/buttons/save as Button
onready var load_button := $a_button/buttons/load as Button

func _ready():
	randomize()
	save_button.connect("button_down",self,"save")
	load_button.connect("button_down",self,"load")

func _unhandled_input(event):
	if event is InputEventMouseButton && event.pressed:
		print(event.position)
		var new_node=a_node.instance()
		new_node.position=event.position
		$some_nodes.add_child(new_node)


#var save_path="res://saves/some_save.tscn"
var save_path="res://saves/some_save.tres"

func save():
	var save_data:Resource=packing_resource.new()
	for child in $some_nodes.get_children():
		save_data.my_resources.append(child.get_savedata())
	ResourceSaver.save(save_path,save_data,64)
	
func load():
	for child in $some_nodes.get_children():
		child.free()
	var load_data=load(save_path)
	for resource in load_data.my_resources:
		var new_obj=resource.entity
		new_obj.load_savedata(resource.state)
		$some_nodes.add_child(new_obj.entity,true)
	pass


func get_all_children(node:Node)->Array:
	var result=[]
	if node.get_child_count() > 0:
		result=node.get_children()
		for child in result:
			result=result+get_all_children(child)
	return result

class packing_resource extends Resource:
	export var my_resources:Array=[]
