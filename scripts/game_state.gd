extends Node

var currency = 10
var elements = {}
var forms = {}
var effects = {}

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
