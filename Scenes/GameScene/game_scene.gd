extends Node2D

const STARTING_BUNNIES: int = 4

var bunny_scene: PackedScene = preload("res://Scenes/Bunny/bunny.tscn")

func _ready() -> void:
	if SceneManager.start_game:
		for i in STARTING_BUNNIES:
			new_bunny()
		SceneManager.start_game = false
	bunny_loader()
	if SceneManager.music_on:
		SceneManager.outdoor_music.play()
		SceneManager.outdoor_music.seek(SceneManager.outdoor_music_time)


func _process(_delta: float) -> void:
	pass

func new_bunny():
	var new_bunny = bunny_scene.instantiate()
	new_bunny.position = Vector2(randi() % 200 + 50, randi() % 100 - 50)
	new_bunny.spawn_position = new_bunny.position
	new_bunny.name = "Bunny" + str(SceneManager.bunny_count)
	SceneManager.bunny_node.add_child(new_bunny)
	SceneManager.bunny_count += 1

func bunny_loader():
	if not SceneManager.bunny_node.get_child_count() == 0:
		for i in SceneManager.bunny_node.get_children():
			i.position = i.spawn_position
			i.reparent($ObstacleLayer/Bunnies)
	
func _exit_tree() -> void:
	if not $ObstacleLayer/Bunnies.get_child_count() == 0:
		for i in $ObstacleLayer/Bunnies.get_children():
			i.spawn_position = i.position
			i.position = Vector2(1000,1000)
			i.reparent(SceneManager.bunny_node)
	if SceneManager.music_on:
		SceneManager.outdoor_music_time = SceneManager.outdoor_music.get_playback_position()
		SceneManager.outdoor_music.stop()
