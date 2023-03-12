extends Node
class_name HealthComponent

signal died

@export var max_health: float = 10
var current_health
var min_health = 0


func _ready():
	current_health = max_health
	

func damage(damage_amount: float):
	current_health = max(current_health - damage_amount, min_health)
	Callable(check_death).call_deferred()
	
func check_death():
	if current_health == min_health:
		died.emit()
		owner.queue_free()
