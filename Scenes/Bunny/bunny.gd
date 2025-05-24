extends StaticBody2D
class_name HungryBunny
@export var bunny_name: String

var has_been_fed: bool = false
var can_interact: bool = false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		if has_been_fed and $CanvasLayer.visible:
			unpause_dialog()
		elif SceneManager.carrot_count > 0 and not has_been_fed:
			if $CanvasLayer.visible:
				unpause_dialog()
			else:
				feed_bunny()
				$CanvasLayer/DialogLabel.text = "Thanks for the carrot!"
				pause_for_dialog()
		elif not has_been_fed:
			if $CanvasLayer.visible:
				unpause_dialog()
			else:
				$CanvasLayer/DialogLabel.text = "Can you please find a carrot\nfor me?"
				pause_for_dialog()
				

func pause_for_dialog():
	$CanvasLayer.visible = true
	get_tree().paused = true
	
func unpause_dialog():
	$CanvasLayer.visible = false
	get_tree().paused = false
	
func feed_bunny():
	SceneManager.carrot_count -= 1
	SceneManager.bunny_count -= 1
	$NeedsCarrot.visible = false
	has_been_fed = true
	if SceneManager.bunny_count == 0:
		SceneManager.has_quest = true
