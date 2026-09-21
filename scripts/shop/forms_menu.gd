extends Control

func _ready() -> void:
	update_currency_display()
	update_projectile_stock()

func update_currency_display() -> void:
	%CurrencyLabel.text = "Currency: %s." %GameState.currency

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/shop.tscn")

func update_projectile_stock():
	%ProjectileStock.text = "In stock: %s" %GameState.forms.get("Projectile", 0)

func buy_form(form, cost):
	if GameState.currency >= cost:
		GameState.currency -= cost
		GameState.forms[form] = GameState.forms.get(form, 0) + 1
		update_currency_display()
		return true
	return false

func sell_form(form, cost):
	if GameState.forms.get(form, 0) > 0:
		GameState.currency += cost
		GameState.forms[form] -= 1

		if GameState.forms[form] == 0:
			GameState.forms.erase(form)

		update_currency_display()
		return true
	return false

func _on_buy_projectile_pressed() -> void:
	if buy_form("Projectile", 5):
		update_projectile_stock()

func _on_sell_projectile_pressed() -> void:
	if sell_form("Projectile", 3):
		update_projectile_stock()
