extends Node2D

@onready var end_screen: Control = $CanvasLayer/EndScreen
@onready var bunnies: Node = $Bunnies
@onready var plots: Node = $Plots
@onready var outdoor_music: AudioStreamPlayer = $Music/Outdoor
@onready var cave_music: AudioStreamPlayer = $Music/Cave
@onready var play_timer: Timer = $PlayTimer

var player_spawn_position: Vector2

var opened_chests: Array[String] = []

var start_game: bool = true
var has_quest: bool = true
var game_won: bool = false
var restarting: bool = false
var carrot_count: int = 0
var bunny_count: int = 0
var total_bunny_count: int = 0
var outdoor_music_time: float = 0.0
var cave_music_time: float = 0.0
var play_time: float = 0.0
var timer_running: bool = true

var music_on: bool = true
var sound_on: bool = true

func _process(delta: float) -> void:
	if timer_running:
		play_time += delta
		
func get_current_time() -> String:
	if play_time < 10:
		return str(int(play_time/60)) + ":0" + str(int(play_time)%60)
	else:
		return str(int(play_time/60)) + ":" + str(int(play_time)%60)
	
	
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart"):
		restart_game()

func restart_game():
	start_game = true
	has_quest = true
	game_won = false
	carrot_count = 0
	bunny_count = 0
	total_bunny_count = 0
	opened_chests = []
	play_time = 0.0
	restarting = true
	end_screen.visible = false
	timer_running = true
	get_tree().reload_current_scene()
	
