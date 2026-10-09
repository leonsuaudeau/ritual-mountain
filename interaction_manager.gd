extends Node

var current_trigger: DialogueTrigger
var dialogue_open := false

func _unhandled_input(event: InputEvent) -> void:
	if dialogue_open:
		return
		
	if event.is_action_pressed("interact") and current_trigger != null:
		current_trigger.interact()
		
func set_current_trigger(trigger: DialogueTrigger) -> void:
	current_trigger = trigger
	
func clear_current_trigger(trigger: DialogueTrigger) -> void:
	if current_trigger == trigger:
		current_trigger = null

# TODO: currently last entered trigger becomes active, add some system that decides
# which trigger should be used.
