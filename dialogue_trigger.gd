class_name DialogueTrigger
extends Area2D

@export var starting_dialogue: DialogueNode
@export var dialogue_box: Control
@export var automatic: bool = false
@export var once: bool = false

var player_inside := false
var already_triggered := false

func _ready() -> void:
	body_entered.connect(_one_body_entered)
	body_exited.connect(_on_body_exited)

func _one_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
		
	player_inside = true
	InteractionManager.set_current_trigger(self)
		
	if automatic and not already_triggered:
		interact()
	
func _on_body_exited(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
		
	player_inside = false
	InteractionManager.clear_current_trigger(self)
		
func interact() -> void:
	if not player_inside and not automatic:
		return
	
	if already_triggered and once:
		return
		
	if starting_dialogue == null:
		return
		
	already_triggered = true
	dialogue_box.start_dialogue(starting_dialogue)
