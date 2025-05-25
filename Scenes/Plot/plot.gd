extends StaticBody2D

var can_interact: bool = false
var carrot_ready: bool = false
var time: float = 0.0
@onready var grow_timer = get_node("GrowTimer")
@export var spawn_position: Vector2

func _ready() -> void:
	start_growing()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		if carrot_ready:
			get_carrot()

func get_carrot():
	SceneManager.carrot_count += 1
	carrot_ready = false
	$AnimatedSprite2D.play("empty")
	$Carrot.position = Vector2(0,0)
	$Carrot.visible = true
	var carrot_move = create_tween()
	carrot_move.tween_property($Carrot, "position", Vector2(0,-8), 1)
	$ShortTimer.start()
	start_growing()
	
func start_growing():
	$GrowTimer.wait_time = randf() * 50.0
	$GrowTimer.start()

func _on_grow_timer_timeout() -> void:
	carrot_ready = true
	$AnimatedSprite2D.play("ready")
	
func _on_short_timer_timeout() -> void:
	$Carrot.visible = false
