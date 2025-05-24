extends StaticBody2D

var has_quest: bool = true
var can_interact: bool = false

func _ready() -> void:
	if has_quest:
		$Exclamation.visible = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		if $CanvasLayer.visible:
			$CanvasLayer.visible = false
		else:
			$CanvasLayer.visible = true
			$Exclamation.visible = false
