extends Control

@onready var user_interface: Control = $"."

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("menu"):
		if SceneManager.sound_on:
			$Sounds/Menu.play()
		if user_interface.visible:
			user_interface.close_menu()
		else:
			user_interface.open_menu()

func open_menu():
	%SoundFXButton.button_pressed = SceneManager.sound_on
	%MusicButton.button_pressed = SceneManager.music_on
	user_interface.visible = true
	get_tree().paused = true

func close_menu():
	user_interface.visible = false
	get_tree().paused = false


func _on_sound_fx_button_pressed() -> void:
	if SceneManager.sound_on:
		SceneManager.sound_on = false
	else:
		SceneManager.sound_on = true


func _on_music_button_pressed() -> void:
	if SceneManager.music_on:
		SceneManager.music_on = false
		SceneManager.outdoor_music.stop()
	else:
		SceneManager.music_on = true
		SceneManager.outdoor_music.play()
