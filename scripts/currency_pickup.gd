extends Area2D

@onready var player = get_node("/root/Game/Player")

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		queue_free()
		player.update_currency(1)
