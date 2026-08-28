@tool
extends PanelContainer

@onready var header_panel: PanelContainer = %HeaderPanel
@onready var title: Label = %Title
@onready var img: TextureRect = %Img
@onready var tag_container: HFlowContainer = %TagContainer
@onready var ability_display: PanelContainer = %AbilityDisplay
@onready var skill: Label = %Skill

const TAG_DISPLAY = preload("uid://csubdu3rcrv4a")

@export var card : Card:
	set(value):
		card = value
		_update()

@export_tool_button("Update", "Reload")
var update_button = _update

func _ready() -> void:
	_update()

func _clean_container(container):
	for child in container.get_children():
		child.queue_free()

func _update():
	if not is_node_ready():
		await ready
	_clean_container(tag_container)
	if card == null:
		header_panel.self_modulate = Color("White")
		title.text = ""
		img.texture = null
		ability_display.ability = null
		skill = null
	else:
		header_panel.self_modulate = Skills.get_skill_color(card.skill)
		title.text = card.title
		skill.text = Skills.get_skill_name(card.skill)
		img.texture = card.img
		_add_tags()
		ability_display.ability = card.ability

func _add_tags() -> void:
	print(card.tags.split(";"))
	for tag in card.tags.split(";"):
		var tag_display := TAG_DISPLAY.instantiate()
		tag_display.text = tag.strip_edges()
		tag_container.add_child(tag_display)
