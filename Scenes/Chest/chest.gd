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
		
		if not $CanvasLayer.visible and not is_open:
			open_chest()
			$CanvasLayer.visible = true
			await get_tree().create_timer(0.1).timeout
			get_tree().paused = true
		else:
			$CanvasLayer.visible = false
			get_tree().paused = false

func open_chest():
	var carrots_found = randi() % 5
	SceneManager.carrot_count += carrots_found
	SceneManager.opened_chests.append(chest_name)
	if carrots_found == 1:
		$CanvasLayer/DialogLabel.text = "You found a carrot!"
	else:
		$CanvasLayer/DialogLabel.text = "You found " + str(carrots_found) + " carrots!"
	is_open = true
	$AnimatedSprite2D.play("open")
	$Carrots.visible = true
	$Timer.start(3)


func _on_timer_timeout() -> void:
	$Carrots.visible = false
