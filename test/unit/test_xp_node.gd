extends GutTest

var xp_node


func before_each() :
	xp_node = XPNode.new()


func after_each() :
	xp_node.free()


func test_set_max_xp() -> void:
	xp_node.set_max_xp(1234)
	assert_eq(xp_node.get_max_xp(), 1234)


func test_increase() -> void:
	watch_signals(xp_node)
	xp_node.increase(9)
	assert_signal_emitted(xp_node, 'xp_updated')
	assert_eq(xp_node.current_xp, 9)


func test_level_up() -> void:
	xp_node.set_max_xp(10)
	watch_signals(xp_node)
	xp_node.increase(11)
	assert_signal_emitted(xp_node, 'xp_updated')
	assert_signal_emitted(xp_node, 'level_up')
	assert_eq(xp_node.current_xp, 0) # XP gets back to 0 when leveling up


func test_level_starts_at_zero() ->  void:
	assert_eq(xp_node.get_current_level(), 0)


func test_max_xp_is_greater_than_zero() -> void:
	assert_gt(xp_node.get_max_xp(), 0)


func test_compute_max_xp() ->  void:
	xp_node.max_xp = 10
	assert_eq(xp_node.get_max_xp(), 10)
	xp_node.level_up()
	assert_eq(xp_node.get_max_xp(), 15)
	xp_node.level_up()
	assert_eq(xp_node.get_max_xp(), 37)
