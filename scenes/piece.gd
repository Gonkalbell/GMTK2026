class_name Piece
extends Area2D

var _selected := false

@onready var tile_map_layer: TileMapLayer = %TileMapLayer


func _place_piece() -> void:
	var map_pos = tile_map_layer.local_to_map(position)
	position = tile_map_layer.map_to_local(map_pos)


func _ready() -> void:
	_place_piece()
	%Timer.paused = true


func _process(_delta: float) -> void:
	if %Timer.paused:
		%Label.text = "X"
	else:
		%Label.text = "%01d" % floorf(%Timer.time_left)


func _on_mouse_entered():
	var tween = create_tween().set_parallel(true)
	tween.tween_property(%Sprite2D, "scale", Vector2(1.1, 1.1), 0.1)
	tween.tween_property(%Sprite2D, "modulate", Color(1.2, 1.2, 1.2), 0.1)  # Brighten


func _on_mouse_exited():
	var tween = create_tween().set_parallel(true)
	tween.tween_property(%Sprite2D, "scale", Vector2(1.0, 1.0), 0.1)
	tween.tween_property(%Sprite2D, "modulate", Color(1, 1, 1), 0.1)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		_selected = event.is_pressed()


func _unhandled_input(event: InputEvent) -> void:
	if _selected and event is InputEventMouseMotion:
		event = event as InputEventMouseMotion
		global_position += event.relative

	if event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.is_released():
		if _selected:
			%Timer.paused = false
			_place_piece()
			_selected = false


func _check_boom(boom_map_pos: Vector2i) -> void:
	var map_pos = tile_map_layer.local_to_map(position)
	for pos in tile_map_layer.get_surrounding_cells(boom_map_pos):
		if pos == map_pos:
			if %Timer.paused:
				%Timer.paused = false
			else:
				await get_tree().process_frame
				_on_timer_timeout()
			return


func _on_timer_timeout() -> void:
	var map_pos = tile_map_layer.local_to_map(position)
	get_tree().call_group("pieces", "_check_boom", map_pos)
	queue_free()
