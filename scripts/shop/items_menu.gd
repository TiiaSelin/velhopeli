extends Control

func _ready() -> void:
	update_currency_display()

func update_currency_display() -> void:
	%CurrencyLabel.text = "Currency: %s." %GameState.currency

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop/shop.tscn")
