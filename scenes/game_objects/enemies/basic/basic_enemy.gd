extends CharacterBody2D

const MAX_SPEED = 40

@onready var health_component: HealthComponent = $HealthComponent

var player_nodes := []
var direction = Vector2.ZERO


func _ready():
	$Area2D.area_entered.connect(on_area_entered)

func _physics_process(delta):
	direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()

func get_direction_to_player():
	player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes != null:
		return (player_nodes[0].global_position - global_position).normalized()
	return Vector2.ZERO


func on_area_entered(other_area:Area2D):
	health_component.damage(100)
	#queue_free()
