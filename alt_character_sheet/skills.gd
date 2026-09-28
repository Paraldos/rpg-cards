@tool
extends VBoxContainer
@onready var skills_container: VBoxContainer = $SkillsContainer
const ATTRIBUT = preload("uid://cqmftbh5uj3r1")
@export var skills: Array[String] = []:
	set(value):
		skills = value
		_update()

func _ready() -> void:
	_update()

func _update() -> void:
	if not is_node_ready():
		return
	for child in skills_container.get_children():
		child.queue_free()

	var sorted_skills := skills.duplicate()
	sorted_skills.sort()
	for skill in sorted_skills:
		var attribut = ATTRIBUT.instantiate()
		attribut.label_txt = skill
		skills_container.add_child(attribut)
	for i in 2:
		var attribut = ATTRIBUT.instantiate()
		attribut.label_txt = ""
		skills_container.add_child(attribut)
