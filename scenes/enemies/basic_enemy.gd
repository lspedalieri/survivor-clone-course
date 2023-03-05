extends CharacterBody2D

const MAX_SPEED = 75

var player_nodes := []
var direction = Vector2.ZERO


func _ready():
	pass

func _physics_process(delta):
	direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()

func get_direction_to_player():
	player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes != null:
		return (player_nodes[0].global_position - global_position).normalized()
	return Vector2.ZERO
