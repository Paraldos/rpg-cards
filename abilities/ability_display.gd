@tool
extends PanelContainer

@onready var title_label: Label = %Title
@onready var cost_label: Label = %Cost
@onready var description_label: Label = %Description

@export var ability: Ability:
	set(value):
		ability = value
		_update()

func _ready() -> void:
	_update()

func _update() -> void:
	if not is_node_ready():
		await ready
	if ability == null:
		title_label.text = ""
		cost_label.text = ""
		description_label.text = ""
	else:
		title_label.text = ability.title
		cost_label.text = "Kosten: %s" % ability.get_cost_text()
		description_label.text = ability.description
	custom_minimum_size.y = 0
	call_deferred("_update_height")

func _update_height() -> void:
	custom_minimum_size.y = get_combined_minimum_size().y
