extends RigidBody2D

var impulseForce : int = 1200

func _process(_delta: float) -> void:
	if Input.is_action_just_released("click"):
		apply_central_impulse(Vector2.UP * impulseForce)
		
