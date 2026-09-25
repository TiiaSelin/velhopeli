class_name Inventory
extends Resource

var slots: Array[InventorySlot] = []
const MAX_SLOTS = 3

signal inventory_changed

class InventorySlot:
	var item: ItemData

	func _init(item: ItemData) -> void:
		self.item = item

func add_item(item: ItemData) -> bool:
	if slots.size() >= MAX_SLOTS:
		return false

	slots.append(InventorySlot.new(item))
	inventory_changed.emit()
	return true

func get_item_in_slot(slot_index: int) -> ItemData:
	if slot_index < 0 or slot_index >= slots.size():
		return null

	return slots[slot_index].item

func remove_item(item: ItemData) -> bool:
	for slot in slots:
		if slot.item == item:
			slots.erase(slot)
			inventory_changed.emit()
			return true

	return false

func use_item(item: ItemData) -> bool:
	if item == null:
		return false

	return remove_item(item)

func get_item_count(item: ItemData) -> int:
	var count := 0

	for slot in slots:
		if slot.item == item:
			count += 1

	return count
