extends Control

@onready var character_selection = preload("res://scenes/character_selection.tscn")

func _on_character_selection_pressed() -> void:
	get_tree().change_scene_to_packed(character_selection)

func _on_controls_pressed() -> void:
	print("Controls pressed.")
