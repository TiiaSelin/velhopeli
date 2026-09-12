class_name Inventory
extends Resource

var slots: Array[InventorySlot] = []
const MAX_SLOTS = 10

class InventorySlot:
	var item: ItemData
	var quantity: int

	func _init(item: ItemData, quantity: int = 1) -> void:
		self.item = item
		self.quantity = quantity

func add_item(item, amount = 1) -> void:
	for slot in slots:
		if slot.item == item:
			slot.quantity += amount
			return

	for slot in slots:
		if slot.item == null:
			slot.item = item
			slot.quantity = amount
			return

	if slots.size() < MAX_SLOTS:
		slots.append(InventorySlot.new(item, amount))

func get_item_in_slot(slot_index: int) -> ItemData:
	if slot_index < 0 or slot_index >= slots.size():
		return null

	return slots[slot_index].item

func remove_item(item, amount = 1) -> void:
	for slot in slots:
		if slot.item == item:
			slot.quantity -= amount

			if slot.quantity <= 0:
				slot.item = null
				slot.quantity = 0

			return

func use_item(item) -> bool:
	if item == null:
		return false

	for slot in slots:
		if slot.item == item:
			remove_item(item)
			return true

	return false

func get_item_count(item) -> int:
	for slot in slots:
		if slot.item == item:
			return slot.quantity

	return 0
