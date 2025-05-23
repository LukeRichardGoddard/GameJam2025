extends CharacterBody2D
class_name Player

@export var move_speed: float = 100

func _ready() -> void:
	position = SceneManager.player_spawn_position 


func _process(delta: float) -> void:
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = move_vector * move_speed
	
	if velocity.x > 0 && velocity.y == 0:
		$AnimatedSprite2D.play("move_right")
		
	elif velocity.x < 0 && velocity.y == 0:
		$AnimatedSprite2D.play("move_left")
		
	elif velocity.x == 0 && velocity.y < 0:
		$AnimatedSprite2D.play("move_up")
		
	elif velocity.x == 0 && velocity.y > 0:
		$AnimatedSprite2D.play("move_down")
	
	elif velocity.x > 0 && velocity.y < 0:
		$AnimatedSprite2D.play("move_upright")
		
	elif velocity.x < 0 && velocity.y < 0:
		$AnimatedSprite2D.play("move_upleft")
		
	elif velocity.x > 0 && velocity.y > 0:
		$AnimatedSprite2D.play("move_downright")
		
	elif velocity.x < 0 && velocity.y > 0:
		$AnimatedSprite2D.play("move_downleft")
	
	else:
		$AnimatedSprite2D.stop()
	
	move_and_slide()
