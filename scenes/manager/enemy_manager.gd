extends Node

@export var basic_enemy_scene:PackedScene

const SPAWN_RADIUS = 330

var player:Node2D
var random_direction:Vector2
var enemy:Node2D

func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	var spawn_position = spawn_location()
	instantiateEnemy(spawn_position)
	
	
func instantiateEnemy(spawn_position):
	enemy = basic_enemy_scene.instantiate() as Node2D
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position


func spawn_location() -> Vector2:
	random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	return player.global_position + (random_direction * SPAWN_RADIUS)
