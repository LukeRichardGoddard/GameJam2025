extends Node2D

var player_spawn_position: Vector2

var opened_chests: Array[String] = []

var has_quest: bool = true
var carrot_count: int = 0
var bunny_count: int = 0
var bunnies: Array[PackedScene] = []
var bunny_node

func _ready() -> void:
	bunny_node = $Bunnies
