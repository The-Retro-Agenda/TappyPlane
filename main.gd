extends Node

@export var obstacleScene : PackedScene
var spawnedOffsetX : int = 1700
var random : int

@export var coinScene : PackedScene


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
	

func _on_spawner_timer_timeout() -> void:
	random = randi() % 2
	var obstacleInstance : Area2D = obstacleScene.instantiate()
	add_child(obstacleInstance)
	obstacleInstance.position.x = spawnedOffsetX
	if random == 0:
		obstacleInstance.position.y = 200
	else:
		obstacleInstance.position.y = 800
		obstacleInstance.scale.y *= -1
		
func _on_coin_timer_timeout() -> void:
	random = randi() % 3
	var coinInstance : Area2D = coinScene.instantiate()
	add_child(coinInstance)
	coinInstance.position.x = spawnedOffsetX
	coinInstance.position.y = 200 + random * 200
	

	
	#0
	
	#1
	
	#2
	
