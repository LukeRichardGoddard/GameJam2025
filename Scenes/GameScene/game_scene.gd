extends Node2D

var bunny_scene: PackedScene = preload("res://Scenes/Bunny/bunny.tscn")

func _ready() -> void:
	if SceneManager.start_game:
		for i in 3:
			new_bunny()
		print(SceneManager.start_game)
		SceneManager.start_game = false
	bunny_loader()


func _process(_delta: float) -> void:
	pass

func new_bunny():
	var new_bunny = bunny_scene.instantiate()
	new_bunny.position = Vector2(randi() % 100 - 50, randi() % 100 - 50)
	new_bunny.name = "Bunny" + str(SceneManager.bunny_count)
	SceneManager.bunny_node.add_child(new_bunny)
	SceneManager.bunny_count += 1

func bunny_loader():
	if not SceneManager.bunny_node.get_child_count() == 0:
		for i in SceneManager.bunny_node.get_children():
			#i.set_process(true)
			i.position = i.spawn_position
			i.reparent($ObstacleLayer/Bunnies)
	
func _exit_tree() -> void:
	if not $ObstacleLayer/Bunnies.get_child_count() == 0:
		for i in $ObstacleLayer/Bunnies.get_children():
			#i.set_process(false)
			i.spawn_position = i.position
			i.position = Vector2(1000,1000)
			i.reparent(SceneManager.bunny_node)
			print(i.name)
