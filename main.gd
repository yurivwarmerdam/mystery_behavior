extends Node

onready var a_node=preload("res://a_node.tscn")
onready var save_button := $a_button/buttons/save as Button
onready var load_button := $a_button/buttons/load as Button
var save_path="res://saves/some_save.tres"


func _ready():
	randomize()
	save_button.connect("button_down",self,"simple_save")
	load_button.connect("button_down",self,"simple_load")

func _unhandled_input(event):
	if event is InputEventMouseButton && event.pressed:
		print(event.position)
		var new_node=a_node.instance()
		new_node.position=event.position
		$some_nodes.add_child(new_node)


var simple_save_path="res://saves/simple_save.tres"
var simple_resource:SimpleResource


func simple_save():
	ResourceSaver.save(simple_save_path,simple_resource)

func simple_load():
	var simple_file=File.new()
	if !simple_file.file_exists(simple_save_path):
		simple_resource=SimpleResource.new()
		simple_resource.state="hello world!"
		var inner_res=InnerResource.new()
		var inner_res2=InnerResource.new()
		inner_res.state=Color(randf(),randf(),randf())
		inner_res2.state=Color(randf(),randf(),randf())
		simple_resource.inner_state={
			"key1":inner_res,
			"key2":inner_res2
		}
		print(simple_resource.state,simple_resource.inner_state)
	else:
		simple_resource=ResourceLoader.load(simple_save_path)
		print(simple_resource.state)
		for i in simple_resource.inner_state.keys():
			print(i,":",simple_resource.inner_state[i].state)


func save():
	print("saving")
	var save_data:Resource=packing_resource.new()
	for child in $some_nodes.get_children():
		save_data.my_resources[child.name]=(child.get_savedata())
	
	pass
	ResourceSaver.save(save_path,save_data)
	
func load():
	for child in $some_nodes.get_children():
		child.free()
	var load_data=ResourceLoader.load(save_path,"",true)
	print("--------")
	print(load_data.my_resources.keys())
	for key in load_data.my_resources.keys():
		var resource=load_data.my_resources[key]
		var new_obj=load(resource.entity).instance()
		new_obj.load_savedata(resource.state)
		new_obj.position=resource.position
		new_obj.name=key
		$some_nodes.add_child(new_obj,true)
	pass


func get_all_children(node:Node)->Array:
	var result=[]
	if node.get_child_count() > 0:
		result=node.get_children()
		for child in result:
			result=result+get_all_children(child)
	return result

class packing_resource extends Resource:
	export var my_resources:Dictionary
