extends Node2D

var player_spawn_position: Vector2

var opened_chests: Array[String] = []

var start_game: bool = true
var has_quest: bool = true
var carrot_count: int = 0
var bunny_count: int = 0
var total_bunny_count: int = 0
var bunnies: Node
var plots: Node
var outdoor_music: AudioStreamPlayer
var outdoor_music_time: float = 0.0
var cave_music: AudioStreamPlayer
var cave_music_time: float = 0.0
var play_timer: Timer
var play_time: float = 0.0

var music_on: bool = true
var sound_on: bool = true

func _ready() -> void:
	bunnies = $Bunnies
	plots = $Plots
	outdoor_music = $Music/Outdoor
	cave_music = $Music/Cave
	play_timer = $PlayTimer
	

#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("quit"):
		#get_tree().quit()
