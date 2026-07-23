extends Area2D

var _selected := false


func _process(_delta: float) -> void:
	%Label.text = "%02d" % floorf(%Timer.time_left)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	event = event as InputEventMouseButton

	if event and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		_selected = event.is_pressed()


func _unhandled_input(event: InputEvent) -> void:
	if _selected and event is InputEventMouseMotion:
		event = event as InputEventMouseMotion
		global_position += event.relative

	if event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.is_released():
		_selected = false
