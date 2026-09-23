extends Area2D

@onready var player = get_node("/root/Game/Player")

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		GameState.elements["Fire"] = GameState.elements.get("Fire", 0) + 1
		queue_free()
