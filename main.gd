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
var save_path="res://saves/some_save01.tscn"

func save():
	var save_data=PackedScene.new()
	var all_children=get_all_children($some_nodes)
	for child in all_children:
		print("owner: ",child.owner)
		if child.get_owner() == null:
			child.set_owner($some_nodes)

	save_data.pack($some_nodes)
	ResourceSaver.save(save_path,save_data)
	
func load():
	$some_nodes.free()
	var load_data=load(save_path).instance()
	add_child(load_data,true)
	pass


func get_all_children(node:Node)->Array:
	var result=[]
	if node.get_child_count() > 0:
		result=node.get_children()
		for child in result:
			result=result+get_all_children(child)
	return result
