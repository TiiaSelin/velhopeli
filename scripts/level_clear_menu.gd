extends Control

func _ready() -> void:
	%CurrencyLabel.text = "Currency: %s." %GameState.currency
	%CurrentSpellText.text = "Current spell: %s, %s, %s." % [
	("%s x%d" % [
		GameState.selected_spell["element"],
		GameState.selected_spell["element_power"]
	]) if GameState.selected_spell["element"] else "No element",
	("%s x%d" % [
		GameState.selected_spell["form"],
		GameState.selected_spell["form_power"]
	]) if GameState.selected_spell["form"] else "No form",
	("%s x%d" % [
		GameState.selected_spell["effect"],
		GameState.selected_spell["effect_power"]
	]) if GameState.selected_spell["effect"] else "No effect"
	]
	%Slot1Item.texture = GameState.inventory.get_item_in_slot(0).icon if GameState.inventory.get_item_in_slot(0) else null
	%Slot2Item.texture = GameState.inventory.get_item_in_slot(1).icon if GameState.inventory.get_item_in_slot(1) else null
	%Slot3Item.texture = GameState.inventory.get_item_in_slot(2).icon if GameState.inventory.get_item_in_slot(2) else null


func _on_next_level_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/shop.tscn")

func _on_spell_editor_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/spell_editor.tscn")
