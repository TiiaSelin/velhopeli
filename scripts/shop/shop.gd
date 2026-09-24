extends Control

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_clear_menu.tscn")

func _on_elements_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/elements_menu.tscn")

func _on_forms_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/forms_menu.tscn")

func _on_effects_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/effects_menu.tscn")

func _on_items_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/items_menu.tscn")
