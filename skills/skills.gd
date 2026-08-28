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

static func get_skill_color(skill: SKILLS) -> Color:
	match skill:
		SKILLS.STRENGTH:
			return Color("f22736")
		SKILLS.DEX:
			return Color("38b01f")
		SKILLS.CHARM:
			return Color("f2c420")
		SKILLS.WITS:
			return Color("1583d3")
		_:
			return Color("ffffff")
