extends StaticBody2D

var can_interact: bool = false
var carrot_ready: bool = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		if carrot_ready:
			get_carrot()

func get_carrot():
	SceneManager.carrot_count += 1
	carrot_ready = false
	$Carrot.visible = true
	$ShortTimer.start()
	$GrowTimer.wait_time = randf() * 5.0
	$GrowTimer.start()
	$AnimatedSprite2D.play("empty")

func _on_grow_timer_timeout() -> void:
	carrot_ready = true
	$AnimatedSprite2D.play("ready")
	
func _on_short_timer_timeout() -> void:
	$Carrot.visible = false
