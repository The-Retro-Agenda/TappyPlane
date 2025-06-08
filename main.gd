extends Node

# obstacle variables
@export var obstacleScene : PackedScene
var spawnedOffsetX : int = 1700
var random : int
var lastObstaclePosition : String

# coin variables
@export var coinScene : PackedScene
@export var coinHealth : float

# scrolling speed
var dynamicObjectSpeed : int = 700

# player variables
@export var healthDecreaseSpeed : int = 5
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
	else:
		_game_over()
		
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
	obstacleInstance.body_entered.connect(_on_obstacle_collided)
	
	if random == 0:
		obstacleInstance.position.y = 200
		lastObstaclePosition = "up"
	else:
		obstacleInstance.position.y = 800
		obstacleInstance.scale.y *= -1
		lastObstaclePosition = "down"
		
func _on_coin_timer_timeout() -> void:
	random = randi() % 3
	
	if lastObstaclePosition == "up" and random == 0:
		return
	
	if lastObstaclePosition == "down" and random == 2:
		return
	
	var coinInstance : Area2D = coinScene.instantiate()
	add_child(coinInstance)
	coinInstance.position.x = spawnedOffsetX
	coinInstance.position.y = 280 + random * 200
	coinInstance.body_entered.connect(_on_coin_collided.bind(coinInstance))
	
func _on_coin_collided(body : Node2D, coinInstance : Area2D) -> void:
	
	if body.is_in_group("Player"):
		health += coinHealth
		if health > 100:
			health = 100
		coinInstance.queue_free()
	
func _on_obstacle_collided(body : Node2D) -> void:
	if body.is_in_group("Player"):
		#health -= coinHealth
		#if health <= 0:
			_game_over()
	
func _game_over() -> void:
	$GameOver.show()
	get_tree().paused = true
	
		
	
