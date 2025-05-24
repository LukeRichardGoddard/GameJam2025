extends StaticBody2D

var can_interact: bool = false
var is_open: bool = false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		if not is_open:
			open_chest()

func open_chest():
	is_open = true
	$AnimatedSprite2D.play("open")
