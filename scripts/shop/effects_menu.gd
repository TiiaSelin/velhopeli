extends Control

func _ready() -> void:
	update_currency_display()
	update_explosion_stock()

func update_currency_display() -> void:
	%CurrencyLabel.text = "Currency: %s." %GameState.currency

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/shop.tscn")

func update_explosion_stock():
	%ExplosionStock.text = "In stock: %s" %GameState.effects.count("Explosion")

func buy_effect(effect, cost):
	if GameState.currency >= cost:
		GameState.currency -= cost
		GameState.effects.append(effect)
		update_currency_display()
		return true
	return false

func sell_effect(effect, cost):
	if GameState.effects.has(effect):
		GameState.currency += cost
		GameState.effects.erase(effect)
		update_currency_display()
		return true
	return false

func _on_buy_explosion_pressed() -> void:
	if (buy_effect("Explosion", 5)):
		update_explosion_stock()

func _on_sell_explosion_pressed() -> void:
	if (sell_effect("Explosion", 3)):
		update_explosion_stock()
