extends Node

var selected_character = 0

var health_potion = preload("res://resources/items/health_potion.tres")
var mana_potion = preload("res://resources/items/mana_potion.tres")

var currency = 10
var elements = {}
var forms = {}
var effects = {}
var inventory: Inventory = Inventory.new()

var default_spell = {
	"element": "None",
	"element_power": 1,
	"form": "Projectile",
	"form_power": 1,
	"effect": "None",
	"effect_power": 1
}

var selected_spell = {
	"element": null,
	"element_power": 1,
	"form": null,
	"form_power": 1,
	"effect": null,
	"effect_power": 1
}

func _ready() -> void:
	inventory.add_item(health_potion)
	inventory.add_item(mana_potion)
