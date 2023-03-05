extends Node

@export var sword_ability :PackedScene 

var sword_instance
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	
func on_timer_timeout():
	player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	if player == null:
		return
	sword_instance = sword_ability.instantiate() as Node2D
	player.get_parent().add_child(sword_instance)
	sword_instance.global_position = player.global_position
