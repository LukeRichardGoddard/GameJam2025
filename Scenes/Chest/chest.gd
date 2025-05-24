extends StaticBody2D

var can_interact: bool = false
var is_open: bool = false

func _ready() -> void:
	$Carrots.visible = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		if not is_open:
			open_chest()

func open_chest():
	is_open = true
	$AnimatedSprite2D.play("open")
	$Carrots.visible = true
	$Timer.start(3)


func _on_timer_timeout() -> void:
	$Carrots.visible = false
