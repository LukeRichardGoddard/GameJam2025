extends StaticBody2D

var can_interact: bool = false

@export var dialog_lines: Array[String] = []
var dialog_index: int = 0

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if SceneManager.has_quest:
		$Exclamation.visible = true
		
	if Input.is_action_just_pressed("interact") and can_interact:
		if SceneManager.sound_on:
			$Sounds/NextDialog.play()
		if SceneManager.bunny_count == 0:
			dialog_lines = ["Thanks for feeding the\nbunnies!"]
		
		if dialog_index < dialog_lines.size():
			$CanvasLayer.visible = true
			get_tree().paused = true
			$CanvasLayer/DialogLabel.text = dialog_lines[dialog_index]
			dialog_index += 1
		else:
			$Exclamation.visible = false
			$CanvasLayer.visible = false
			get_tree().paused = false
			dialog_index = 0
			SceneManager.has_quest = false
			
