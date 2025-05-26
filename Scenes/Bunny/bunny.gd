extends CharacterBody2D
class_name HungryBunny

var has_been_fed: bool = false
var can_interact: bool = false
var carrot_tween = create_tween().set_loops()
@export var speed: int = 500

var is_spawning: bool = true
var spawn_position: Vector2

var current_position: Vector2
var current_velocity: Vector2
var velocity_norm: Vector2
var destination: Vector2
var dist_to_dest: Vector2
var direction_normal: Vector2

func _physics_process(_delta: float) -> void:
	if destination:
		dist_to_dest = destination - global_position
		direction_normal = dist_to_dest.normalized()
		if (dist_to_dest.x > 2 or dist_to_dest.x < 2) and (dist_to_dest.y > 2 or dist_to_dest.y < 2) :
			velocity = direction_normal * speed * _delta
			animate_bunny()
		else:
			velocity = Vector2.ZERO
			$AnimatedSprite2D.stop()
	else:
		randomiseDestination()
	move_and_slide()

func animate_bunny():
	current_position = position
	current_velocity = velocity
	velocity_norm = velocity.normalized()
	if velocity_norm.x > 0.5 && (velocity_norm.y < 0.5 && velocity_norm.y > -0.5):
		$AnimatedSprite2D.play("move_right")
		
	elif velocity_norm.x < -0.5 && (velocity_norm.y < 0.5 && velocity_norm.y > -0.5):
		$AnimatedSprite2D.play("move_left")
		
	elif (velocity_norm.x < 0.5 && velocity_norm.x > -0.5) && velocity_norm.y < -0.5:
		$AnimatedSprite2D.play("move_up")
		
	elif (velocity_norm.x < 0.5 && velocity_norm.x > -0.5) && velocity_norm.y > 0.5:
		$AnimatedSprite2D.play("move_down")
	
	elif velocity_norm.x > 0.5 && velocity_norm.y < -0.5:
		$AnimatedSprite2D.play("move_upright")
		
	elif velocity_norm.x < -0.5 && velocity_norm.y < -0.5:
		$AnimatedSprite2D.play("move_upleft")
		
	elif velocity_norm.x > 0.5 && velocity_norm.y > 0.5:
		$AnimatedSprite2D.play("move_downright")
		
	elif velocity_norm.x < -0.5 && velocity_norm.y > 0.5:
		$AnimatedSprite2D.play("move_downleft")
	else:
		$AnimatedSprite2D.stop()

func randomiseDestination():
	randomize()
	destination = Vector2(randi() % 16 * 30 - 160, randi() % 16 * -14 + 64)
	
func randomisePosition():
	randomize()
	position = Vector2(randi() % 16 * 30 - 160, randi() % 16 * -14 + 64)

func _ready() -> void:
	carrot_tween.tween_property($NeedsCarrot, "modulate:a", 0, 2).from_current()
	_on_timer_timeout()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		if has_been_fed and $CanvasLayer.visible:
			unpause_dialog()
		elif SceneManager.carrot_count > 0 and not has_been_fed:
			feed_bunny()
		elif not has_been_fed:
			if SceneManager.sound_on:
				$Sounds/NextDialog.play()
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
	if SceneManager.sound_on:
		$Sounds/EatCarrot.play()
	SceneManager.carrot_count -= 1
	SceneManager.bunny_count -= 1
	$NeedsCarrot.visible = false
	carrot_tween.stop()
	
	var bunny_tween = create_tween()
	bunny_tween.tween_property($AnimatedSprite2D, "modulate:a", 0, 2)
	$RemoveTimer.start()
	has_been_fed = true
	if SceneManager.bunny_count == 0:
		#add win condition here
		if SceneManager.sound_on:
			$Sounds/Won.play()
		SceneManager.has_quest = true

func _on_timer_timeout() -> void:
	randomiseDestination()
	$MoveTimer.wait_time = randf() * 2.0
	$MoveTimer.start()


func _on_remove_timer_timeout() -> void:
	self.queue_free()
