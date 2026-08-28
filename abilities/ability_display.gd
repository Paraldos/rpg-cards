extends PanelContainer

@onready var title: Label = %Title
@onready var cost: Label = %Cost
@onready var description: Label = %Description

@export var ability : Ability

func _update():
	title.text = ability.title
	cost.text = ability.get_cost_text()
	description.text = ability.description
