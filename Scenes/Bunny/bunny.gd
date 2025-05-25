extends CharacterBody2D
class_name HungryBunny

var has_been_fed: bool = false
var can_interact: bool = false
var carrot_tween = create_tween().set_loops()

var spawn_position: Vector2

var destination: Vector2
var dist_to_dest: Vector2
var direction_normal: Vector2

func _physics_process(_delta: float) -> void:
	if destination:
		dist_to_dest = destination - global_position
		direction_normal = dist_to_dest.normalized()
		velocity = direction_normal * 100 * _delta
		if dist_to_dest.x * dist_to_dest.y < 3:
			randomiseDestination()
	else:
		randomiseDestination()
	
	move_and_slide()

func randomiseDestination():
	randomize()
	destination = Vector2(randi() % 100 - 50, randi() % 100 - 50)

func _ready() -> void:
	carrot_tween.tween_property($NeedsCarrot, "modulate:a", 0, 2).from_current()

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
	carrot_tween.stop()
	has_been_fed = true
	if SceneManager.bunny_count == 0:
		SceneManager.has_quest = true
