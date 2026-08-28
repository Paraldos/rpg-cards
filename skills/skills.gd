@tool
extends Resource
class_name Skills

enum SKILLS {
	STRENGTH,
	DEX,
	CHARM,
	WITS
}

static func get_skill_name(skill: SKILLS) -> String:
	match skill:
		SKILLS.STRENGTH:
			return "Muckis"
		SKILLS.DEX:
			return "Tricks"
		SKILLS.CHARM:
			return "Charm"
		SKILLS.WITS:
			return "Köpfchen"
		_:
			return ""
