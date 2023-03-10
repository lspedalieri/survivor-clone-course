extends Camera2D

@export var camera_offset:int = 20

var player 
var player_nodes := []
var target_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * camera_offset))
	
func acquire_target():
	player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		player = player_nodes[0] as Node2D
		target_position = player.global_position
		global_position = player.global_position
