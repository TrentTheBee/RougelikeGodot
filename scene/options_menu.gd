extends Control

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scene/menu.tscn")


func _on_controls_pressed():
	get_tree().change_scene_to_file("res://scene/controls_menu.tscn")
