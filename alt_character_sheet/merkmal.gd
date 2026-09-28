@tool
extends HBoxContainer

@onready var label: Label = $Label
@onready var box_container: GridContainer = $BoxContainer
const BOX = preload("uid://cv7xs5vsfjgv1")

@export var label_txt: String = "":
	set(value):
		label_txt = value
		_update()
@export_range(0, 20) var amount: int = 6:
	set(value):
		amount = value
		_update()

func _ready() -> void:
	_update()

func _update() -> void:
	if not is_node_ready():
		return
	label.text = label_txt
	for child in box_container.get_children():
		child.queue_free()
	for i in amount:
		if i > 0 and i % 3 == 0:
			var spacer := Control.new()
			spacer.custom_minimum_size.x = 10
			box_container.add_child(spacer)
		var box = BOX.instantiate()
		box_container.add_child(box)
