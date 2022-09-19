extends Node

onready var a_node=preload("res://a_node.tscn")
onready var save_button := $a_button/buttons/save as Button
onready var load_button := $a_button/buttons/load as Button
var save_path="res://saves/some_save.tres"

func _ready():
	randomize()
	save_button.connect("button_down",self,"do_save_simple_resource")
	load_button.connect("button_down",self,"do_load_simple_resource")

func _unhandled_input(event):
	if event is InputEventMouseButton && event.pressed:
		print(event.position)
		var new_node=a_node.instance()
		new_node.position=event.position
		$some_nodes.add_child(new_node)

var simple_save:String="rest://saves/simlpe_save.tres"
var simple_resource:SimpleResource
func do_save_simple_resource():
	
	pass

func do_load_simple_resource():
	var my_file=!File.new()
	my_file.file_exists(simple_save)
	SimpleResource.new()
	
	pass

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
		var new_obj=resource.prefab.instance()
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
