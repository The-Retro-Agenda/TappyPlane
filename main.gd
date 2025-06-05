extends Node

var dynamicObjectSpeed : int = 700
var healthDecreaseSpeed : int = 3
var health : float = 100
var score : float = 0
var formattedScore : String = str(score)
var decimalIndex = formattedScore.find(".")


func _process(delta: float) -> void:
	for dynamic_object in get_tree().get_nodes_in_group("DynamicObject"):
		dynamic_object.position.x -= delta * dynamicObjectSpeed
	if health > 0:
		health -= delta * healthDecreaseSpeed
		$UI/HealthBar.value = health
		
	score += delta
	formattedScore = str(score)
	formattedScore = formattedScore.left(decimalIndex + 3)
	$UI/HealthBar/ScoreLabel.text = formattedScore
	#else:
		#print("Game Over")
	
		
		
