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
	%FireStock.text = "In stock: %s" %GameState.elements.get("Fire", 0)

func update_ice_stock():
	%IceStock.text = "In stock: %s" %GameState.elements.get("Ice", 0)

func buy_element(element, cost):
	if GameState.currency >= cost:
		GameState.currency -= cost
		GameState.elements[element] = GameState.elements.get(element, 0) + 1
		update_currency_display()
		return true
	return false

func sell_element(element, cost):
	if GameState.elements.get(element, 0) > 0:
		GameState.currency += cost
		GameState.elements[element] -= 1

		if GameState.elements[element] == 0:
			GameState.elements.erase(element)

		update_currency_display()
		return true
	return false

func _on_buy_fire_pressed() -> void:
	if buy_element("Fire", 5):
		update_fire_stock()

func _on_sell_fire_pressed() -> void:
	if sell_element("Fire", 3):
		update_fire_stock()

func _on_buy_ice_pressed() -> void:
	if buy_element("Ice", 5):
		update_ice_stock()

func _on_sell_ice_pressed() -> void:
	if sell_element("Ice", 3):
		update_ice_stock()
