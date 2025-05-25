extends Node2D

const STARTING_BUNNIES: int = 3

var bunny_scene: PackedScene = preload("res://Scenes/Bunny/bunny.tscn")

func _ready() -> void:
	bunny_loader()
	plot_loader()
	if SceneManager.start_game:
		for i in STARTING_BUNNIES:
			new_bunny()
		SceneManager.start_game = false
	$NewBunnyTimer.wait_time = randf() * 30 + 5.0
	$NewBunnyTimer.start()
	if SceneManager.music_on:
		SceneManager.outdoor_music.play()
		SceneManager.outdoor_music.seek(SceneManager.outdoor_music_time)


func _process(_delta: float) -> void:
	pass

func new_bunny():
	var instant_bunny = bunny_scene.instantiate()
	instant_bunny.position = Vector2(randi() % 16 * 10, randi() % 16 * 5)
	instant_bunny.spawn_position = instant_bunny.position
	instant_bunny.name = "Bunny" + str(SceneManager.bunny_count)
	$ObstacleLayer/Bunnies.add_child(instant_bunny)
	SceneManager.bunny_count += 1
	SceneManager.total_bunny_count += 1

func bunny_loader():
	if not SceneManager.bunnies.get_child_count() == 0:
		for child in SceneManager.bunnies.get_children():
			child.position = child.spawn_position
			child.reparent($ObstacleLayer/Bunnies)
	
func plot_loader():
	if not SceneManager.plots.get_child_count() == 0:
		for child in SceneManager.plots.get_children():
			child.grow_timer.wait_time = child.time
			child.grow_timer.start()
			child.position = child.spawn_position
			child.reparent($Plots)
	
func _exit_tree() -> void:
	if not $ObstacleLayer/Bunnies.get_child_count() == 0:
		for child in $ObstacleLayer/Bunnies.get_children():
			child.spawn_position = child.position
			#move somewhere far away to prevent collisions
			child.position = Vector2(1000,1000)
			child.reparent(SceneManager.bunnies)
	if not $Plots.get_child_count() == 0:
		for child in $Plots.get_children():
			child.spawn_position = child.position
			#move somewhere far away to prevent collisions
			child.position = Vector2(1000,1000)
			child.time = child.grow_timer.wait_time
			child.reparent(SceneManager.plots)
	if SceneManager.music_on:
		SceneManager.outdoor_music_time = SceneManager.outdoor_music.get_playback_position()
		SceneManager.outdoor_music.stop()


func _on_new_bunny_timer_timeout() -> void:
	if SceneManager.bunny_count < 20 and SceneManager.bunny_count > 2:
		new_bunny()
		$NewBunnyTimer.wait_time = randf() * 10
