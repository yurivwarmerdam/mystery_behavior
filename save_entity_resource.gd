extends Resource
class_name SaveEntityResource
export var entity:String
export var state:Resource
export var position:Vector2

func set_data(node:Node2D,state):
	self.entity=node.filename
	self.position=node.position
	self.state=state
