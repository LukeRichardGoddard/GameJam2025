extends Node2D

var bunny_scene: PackedScene = preload("res://Scenes/Bunny/bunny.tscn")

func _ready() -> void:
	if SceneManager.has_quest:
		var new_bunny = bunny_scene.instantiate()
		new_bunny.position = Vector2(randi() % 100 - 50, randi() % 100 - 50)
		new_bunny.bunny_name = "bunny" + str(SceneManager.bunny_count)
		new_bunny.name = "Bunny" + str(SceneManager.bunny_count)
		SceneManager.bunny_node.add_child(new_bunny)
		SceneManager.bunny_count += 1
	bunny_loader()


func _process(_delta: float) -> void:
	pass

func bunny_loader():
	if not SceneManager.bunny_node.get_child_count() == 0:
		for i in SceneManager.bunny_node.get_children():
			print("Found a child")
			i.reparent($ObstacleLayer/Bunnies)
	
func _exit_tree() -> void:
	if not $ObstacleLayer/Bunnies.get_child_count() == 0:
		for i in $ObstacleLayer/Bunnies.get_children():
			print("Found a child")
			i.reparent(SceneManager.bunny_node)
			print(i.name)
