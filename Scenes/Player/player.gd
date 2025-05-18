extends CharacterBody2D

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = move_vector
	
	move_and_slide()
