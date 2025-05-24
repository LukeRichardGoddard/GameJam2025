extends Node2D


func _ready() -> void:
	$Player/AnimatedSprite2D.play("move_up") 


func _process(_delta: float) -> void:
	pass
