extends Control

func _ready() -> void:
	%CurrencyLabel.text = "Currency: %s." %GameState.currency

func _on_next_level_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/shop.tscn")
