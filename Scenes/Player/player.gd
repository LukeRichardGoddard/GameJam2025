extends CharacterBody2D
class_name Player

@export var move_speed: float = 100

func _ready() -> void:
	position = SceneManager.player_spawn_position 


func _process(_delta: float) -> void:
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = move_vector * move_speed
	
	if velocity.x > 0 && velocity.y == 0:
		$AnimatedSprite2D.play("move_right")
		$InteractArea2D.position = Vector2(6,0)
		
	elif velocity.x < 0 && velocity.y == 0:
		$AnimatedSprite2D.play("move_left")
		$InteractArea2D.position = Vector2(-6,0)
		
	elif velocity.x == 0 && velocity.y < 0:
		$AnimatedSprite2D.play("move_up")
		$InteractArea2D.position = Vector2(0,-8)
		
	elif velocity.x == 0 && velocity.y > 0:
		$AnimatedSprite2D.play("move_down")
		$InteractArea2D.position = Vector2(0,8)
	
	elif velocity.x > 0 && velocity.y < 0:
		$AnimatedSprite2D.play("move_upright")
		$InteractArea2D.position = Vector2(6,-8)
		
	elif velocity.x < 0 && velocity.y < 0:
		$AnimatedSprite2D.play("move_upleft")
		$InteractArea2D.position = Vector2(-6,-8)
		
	elif velocity.x > 0 && velocity.y > 0:
		$AnimatedSprite2D.play("move_downright")
		$InteractArea2D.position = Vector2(6,8)
		
	elif velocity.x < 0 && velocity.y > 0:
		$AnimatedSprite2D.play("move_downleft")
		$InteractArea2D.position = Vector2(-6,8)
	
	else:
		$AnimatedSprite2D.stop()
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		body.can_interact = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		body.can_interact = false
