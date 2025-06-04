extends Node

var dynamicObjectSpeed : int = 700

func _process(delta: float) -> void:
	for dynamic_object in get_tree().get_nodes_in_group("DynamicObject"):
		dynamic_object.position.x -= delta * dynamicObjectSpeed
		
		
