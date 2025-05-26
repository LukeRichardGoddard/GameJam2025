extends Control

func _process(delta: float) -> void:
	%EndTimeLabel.text = SceneManager.get_current_time()
	%EndBunniesLabel.text = str(SceneManager.total_bunny_count)
