extends Resource
class_name SpellPartDrop

@export_enum("element", "form", "effect") var part_type: String
@export var part_data: Resource

func get_icon() -> Texture2D:
	return part_data.icon
