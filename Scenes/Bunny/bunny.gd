extends StaticBody2D
class_name HungryBunny
@export var bunny_name: String

var has_been_fed: bool = false
var can_interact: bool = false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		if $CanvasLayer.visible:
			$CanvasLayer.visible = false
		else:
			$CanvasLayer.visible = true
