extends Control

var selected_slot: int = -1
var health_potion = preload("res://resources/items/health_potion.tres")
var mana_potion = preload("res://resources/items/mana_potion.tres")

func _ready() -> void:
	update_currency_display()
	GameState.inventory.inventory_changed.connect(update_items_display)
	update_items_display()

func update_currency_display() -> void:
	%CurrencyLabel.text = "Currency: %s." %GameState.currency

func update_items_display():
	%Slot1Item.texture = GameState.inventory.get_item_in_slot(0).icon if GameState.inventory.get_item_in_slot(0) else null
	%Slot2Item.texture = GameState.inventory.get_item_in_slot(1).icon if GameState.inventory.get_item_in_slot(1) else null
	%Slot3Item.texture = GameState.inventory.get_item_in_slot(2).icon if GameState.inventory.get_item_in_slot(2) else null

func show_sell_panel(slot_index) -> void:
	var item = GameState.inventory.get_item_in_slot(slot_index)

	if item == null:
		return

	selected_slot = slot_index

	%ItemIcon.texture = item.icon
	%ItemLabel.text = item.item_name
	%SellPrice.text = "Sell for $%d?" % item.sell_price

	%SellPanel.visible = true

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/shop.tscn")

func _on_slot_1_pressed() -> void:
	show_sell_panel(0)

func _on_slot_2_pressed() -> void:
	show_sell_panel(1)

func _on_slot_3_pressed() -> void:
	show_sell_panel(2)

func _on_sell_button_pressed() -> void:
	if selected_slot == -1:
		return

	var item = GameState.inventory.get_item_in_slot(selected_slot)

	if item == null:
		return

	GameState.inventory.remove_item(item)
	GameState.currency += item.sell_price

	%SellPanel.visible = false
	selected_slot = -1
	update_currency_display()

func _on_cancel_button_pressed() -> void:
	%SellPanel.visible = false
	selected_slot = -1

func _on_buy_hp_pot_pressed() -> void:
	if GameState.currency < health_potion.buy_price:
		return

	if not GameState.inventory.add_item(health_potion):
		return

	GameState.currency -= health_potion.buy_price
	update_currency_display()

func _on_buy_mp_pot_pressed() -> void:
	if GameState.currency < mana_potion.buy_price:
		return

	if not GameState.inventory.add_item(mana_potion):
		return

	GameState.currency -= mana_potion.buy_price
	update_currency_display()
