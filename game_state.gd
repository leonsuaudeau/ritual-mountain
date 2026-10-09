extends Node

# Simple solution for encoding quest states and relationships for now
# Later should be replaced by a proper system
var flags: Dictionary =  {}

func has_flag(flag: StringName) -> bool:
	return flags.get(flag, false)
	
func set_flag(flag: StringName, value: bool = true) -> void:
	flags[flag] = value
