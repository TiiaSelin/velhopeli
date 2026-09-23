extends Area2D

@onready var player = get_node("/root/Game/Player")
@onready var sprite = $Sprite2D

@export var part_type: String
@export var part_name: String

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		if part_type == "element":
			GameState.elements[part_name] = GameState.elements.get(part_name, 0) + 1
		elif part_type == "form":
			GameState.forms[part_name] = GameState.forms.get(part_name, 0) + 1
		elif part_type == "effect":
			GameState.effects[part_name] = GameState.effects.get(part_name, 0) + 1

		queue_free()

func set_icon(texture: Texture2D):
	$Sprite2D.texture = texture
