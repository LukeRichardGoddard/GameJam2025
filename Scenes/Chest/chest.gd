extends StaticBody2D

var can_interact: bool = false
var is_open: bool = false
@export var chest_name: String

func _ready() -> void:
	if SceneManager.opened_chests.has(chest_name):
		is_open = true
		$AnimatedSprite2D.play("open")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		if not is_open:
			open_chest()

func open_chest():
	is_open = true
	$AnimatedSprite2D.play("open")
	$Carrots.visible = true
	$Timer.start(3)
	SceneManager.opened_chests.append(chest_name)
	print(SceneManager.opened_chests)


func _on_timer_timeout() -> void:
	$Carrots.visible = false
