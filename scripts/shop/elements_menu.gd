extends Control

func _ready() -> void:
	update_currency_display()
	update_fire_stock()
	update_ice_stock()

func update_currency_display() -> void:
	%CurrencyLabel.text = "Currency: %s." %GameState.currency

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/shop.tscn")

func update_fire_stock():
	%FireStock.text = "In stock: %s" %GameState.elements.count("fire")

func update_ice_stock():
	%IceStock.text = "In stock: %s" %GameState.elements.count("ice")

func buy_element(element, cost):
	if GameState.currency >= cost:
		GameState.currency -= cost
		GameState.elements.append(element)
		update_currency_display()
		return true
	return false

func sell_element(element, cost):
	if GameState.elements.has(element):
		GameState.currency += cost
		GameState.elements.erase(element)
		update_currency_display()
		return true
	return false

func _on_buy_fire_pressed() -> void:
	if buy_element("fire", 5):
		update_fire_stock()

func _on_sell_fire_pressed() -> void:
	if sell_element("fire", 3):
		update_fire_stock()

func _on_buy_ice_pressed() -> void:
	if buy_element("ice", 5):
		update_ice_stock()

func _on_sell_ice_pressed() -> void:
	if sell_element("ice", 3):
		update_ice_stock()
