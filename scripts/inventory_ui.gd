extends Control

@onready var icons = [
	$HBoxContainer/Slot1/Icon,
	$HBoxContainer/Slot2/Icon,
	$HBoxContainer/Slot3/Icon
]

func _ready() -> void:
	GameState.inventory.inventory_changed.connect(update_inventory)
	update_inventory()

func update_inventory() -> void:
	for i in range(icons.size()):
		var item = GameState.inventory.get_item_in_slot(i)

		if item != null:
			icons[i].texture = item.icon
			icons[i].visible = true
		else:
			icons[i].visible = false
