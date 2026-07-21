extends Control

#func _ready() -> void:
	#%MasterVolume.set_value_no_signal(AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Master")))
	#%SoundVolume.set_value_no_signal(AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Sound")))
	#%VolumeVolume.set_value_no_signal(AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Volume")))

func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)

func _on_sound_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Sound"), value)

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Volume"), value)
