extends Node2D

@onready var user_interface: Control = $CanvasLayer/UserInterface

const STARTING_BUNNIES: int = 3
const WAIT_BUFFER: float = 2.0
const INITIAL_BUNNY_WAIT_TIME: float = 5.0
const NORMAL_BUNNY_MULTIPLICATION: float = 20.0
const FAST_BUNNY_MULTIPLICATION: float = 5.0
const FAR_FAR_AWAY: Vector2 = Vector2(10000,10000)
const CAVE_SPAWN: Vector2 = Vector2(0,44)
const BUNNY_CRITICAL_MASS: int = 42

var bunny_scene: PackedScene = preload("res://Scenes/Bunny/bunny.tscn")

func _ready() -> void:
	if not SceneManager.restarting:
		bunny_loader()
		plot_loader()
	SceneManager.restarting = false
	if SceneManager.start_game:
		for i in STARTING_BUNNIES:
			new_bunny()
		SceneManager.start_game = false
		$ObstacleLayer/Player.position = Vector2(28,-37)
		user_interface.open_menu()
	$NewBunnyTimer.wait_time = INITIAL_BUNNY_WAIT_TIME
	$NewBunnyTimer.start()
	SceneManager.play_timer.start()
	if SceneManager.music_on:
		SceneManager.outdoor_music.play()
		SceneManager.outdoor_music.seek(SceneManager.outdoor_music_time)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug_add_bunny"):
		new_bunny()
	

func new_bunny():
	var instant_bunny = bunny_scene.instantiate()
	instant_bunny.position = Vector2(randi() % 16 * 30 - 160, randi() % 16 * -14 + 64)
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
	if not SceneManager.restarting:
		if not $ObstacleLayer/Bunnies.get_child_count() == 0:
			for child in $ObstacleLayer/Bunnies.get_children():
				child.spawn_position = child.position
				#move somewhere far away to prevent collisions
				child.position = FAR_FAR_AWAY
				child.reparent(SceneManager.bunnies)
		if not $Plots.get_child_count() == 0:
			for child in $Plots.get_children():
				child.spawn_position = child.position
				#move somewhere far away to prevent collisions
				child.position = FAR_FAR_AWAY
				child.time = child.grow_timer.wait_time
				child.reparent(SceneManager.plots)
	SceneManager.player_spawn_position = CAVE_SPAWN
	if SceneManager.music_on:
		SceneManager.outdoor_music_time = SceneManager.outdoor_music.get_playback_position()
		SceneManager.outdoor_music.stop()


func _on_new_bunny_timer_timeout() -> void:
	if SceneManager.bunny_count < BUNNY_CRITICAL_MASS and SceneManager.bunny_count > 1:
		if SceneManager.sound_on:
			$Sounds/BunnyEnter.play()
		new_bunny()
		if SceneManager.bunny_count > 10:
			$NewBunnyTimer.wait_time = randf() * FAST_BUNNY_MULTIPLICATION + WAIT_BUFFER
		else:
			$NewBunnyTimer.wait_time = randf() * NORMAL_BUNNY_MULTIPLICATION + WAIT_BUFFER
		
