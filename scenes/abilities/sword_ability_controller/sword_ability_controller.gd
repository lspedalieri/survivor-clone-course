extends Node

const MAX_RANGE = 150
@export var sword_ability:PackedScene 

var sword_instance:Node2D
var player:Node2D
var enemies = []
var enemy_offset:int = 4
var enemy_direction:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	
func on_timer_timeout():
	player = get_tree().get_first_node_in_group("player")
	enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(danger_zone)

	if enemies.size() == 0:
		return
	elif enemies.size() > 1:
		enemies.sort_custom(sort_distances)
	sword_swing()

func sword_swing():
	sword_instance = sword_ability.instantiate()
	player.get_parent().add_child(sword_instance)
	sword_instance.global_position = enemies[0].global_position 
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * enemy_offset
	enemy_direction = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()


func sort_distances(a:Node2D, b:Node2D)->bool:
	var a_distance = a.global_position.distance_squared_to(player.global_position)
	var b_distance = b.global_position.distance_squared_to(player.global_position)
	return a_distance < b_distance
	
	
func danger_zone(enemy:Node2D) -> bool:
	return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
