extends Control

signal  dialogue_finished

@onready var speaker_label: Label = $PanelContainer/MarginContainer/VBoxContainer/SpeakerLabel
@onready var dialogue_text: RichTextLabel =  $PanelContainer/MarginContainer/VBoxContainer/DialogueText
@onready var choices: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/Choices

var current_node = DialogueNode

func start_dialogue(start_node: DialogueNode) -> void:
	show()
	show_node(start_node)
	
func show_node(node: DialogueNode)  -> void:
	current_node = node
	speaker_label.text = node.speaker
	dialogue_text.text = node.text
	
	for child in choices.get_children():
		choices.remove_child(child)
		child.queue_free()
		
	var available_responses: Array[DialogueResponse] = []
	
	for response in node.responses:
		if response.required_flag != &"":
			if not GameState.has_flag(response.required_flag):
				continue
		available_responses.append(response)
		
	for response in available_responses:
		var button := Button.new()
		button.text =  response.text
		button.pressed.connect(_on_response_selected.bind(response))
		choices.add_child(button)
		
	if available_responses.is_empty():
		var button := Button.new()
		button.text = "Close"
		button.pressed.connect(_finish_dialogue)
		choices.add_child(button)

func _on_response_selected(response: DialogueResponse) -> void:
	if response.set_flag != &"":
		GameState.set_flag(response.set_flag)
		
	if response.next_node == null:
		_finish_dialogue()
	else:
		show_node(response.next_node)
		
func _finish_dialogue() -> void:
	hide()
	dialogue_finished.emit()
