extends Control

@onready var user_interface: Control = $"."

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("menu"):
		if user_interface.visible:
			user_interface.close_menu()
		else:
			user_interface.open_menu()

func open_menu():
	user_interface.visible = true
	get_tree().paused = true

func close_menu():
	user_interface.visible = false
	get_tree().paused = false
