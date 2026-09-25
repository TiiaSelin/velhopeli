extends Control

func _ready() -> void:
	update_currency_display()
	update_items_display()

func update_currency_display() -> void:
	%CurrencyLabel.text = "Currency: %s." %GameState.currency

func update_items_display():
	%Slot1Item.texture = GameState.inventory.get_item_in_slot(0).icon if GameState.inventory.get_item_in_slot(0) else null
	%Slot2Item.texture = GameState.inventory.get_item_in_slot(1).icon if GameState.inventory.get_item_in_slot(1) else null
	%Slot3Item.texture = GameState.inventory.get_item_in_slot(2).icon if GameState.inventory.get_item_in_slot(2) else null

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/shop.tscn")
