extends Node2D


func _ready() -> void:
	$Player/AnimatedSprite2D.play("move_up") 
	SceneManager.cave_music.play()
	SceneManager.cave_music.seek(SceneManager.cave_music_time)


func _process(_delta: float) -> void:
	pass
	
func _exit_tree() -> void:
	SceneManager.cave_music_time = SceneManager.cave_music.get_playback_position()
	SceneManager.cave_music.stop()
