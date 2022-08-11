extends GutTest

var skill:Skill

func before_each():
	skill = Skill.new()

func after_each():
	skill.free()


func test_skill_starts_with_level_0() -> void:
	assert_eq(skill.get_level(), 0)


func test_level_up() -> void:
	skill.level_up()
	assert_eq(skill.get_level(), 1)

