extends Control

func _ready() -> void:
	%CurrencyLabel.text = "Currency: %s." %GameState.currency
	%CurrentSpellText.text = "Current spell: %s, %s, %s." % [
		GameState.selected_spell["element"], 
		GameState.selected_spell["form"], 
		GameState.selected_spell["effect"]
	]


func _on_next_level_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/shop.tscn")

func _on_spell_editor_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/spell_editor.tscn")
