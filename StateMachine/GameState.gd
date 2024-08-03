class_name StateMachine
extends Node

var curr_state : State = null
var prev_state : State = null

var valid_states := {}

func _ready():
	var states = _recursively_get_states_from_children()
	print(states)
	if states.size() <= 0:
		push_error("State Machine does not have any state")
		return

   # Gather all states the state machine (has to be first to know all states)
	for state in states:
		valid_states[state.name] = state
	for state in states:
		_validate_state_transition_target(state)

   # Assume first node is the first state
	curr_state = states[0]
	curr_state.on_entry()

# STATE ENTRY
func _enter_state(new_state : State):
	new_state.on_entry()

# STATE EXIT
func _exit_state(old_state : State):
	old_state.on_exit()

func transition(event_name: String):
	var state_transitions = curr_state.transitions
	if not event_name in state_transitions:
		push_error("'%s' cannot handle the event/signal '%s'" % [curr_state.name, event_name])
		return

	var on_going_transition: Transition = state_transitions[event_name]
	if not on_going_transition.should_transition():
		return
   
	var target_state = valid_states[on_going_transition.target_state]

	curr_state.on_exit()
	curr_state = target_state # Set the transition early to allow recursive transition

	on_going_transition.on_transition()
	curr_state.on_entry()
	await curr_state.on_process()

func create_state(state_name : String):
	var obj = State.new()
	obj.state_name = state_name

# TRANSITION ACTIVITY
func set_state(new_state : String) -> void:
	prev_state = curr_state
	var targeted_state : State = null
	for child in get_children():
		if child.name == new_state:
			targeted_state = child
			break
	curr_state = targeted_state
	
	if prev_state != null:
		_exit_state(prev_state)
		
	if targeted_state != null:
		_enter_state(targeted_state)

func _validate_state_transition_target(state: State):
	for t in state.transitions.values():
		var is_target_valid = valid_states.has(t.target_state)
		if not is_target_valid:
			push_error("Invalid target for t in state '%s' in signal '%s' with the target of '%s'" % [state.name, t.name, t.target_state])


func _recursively_get_states_from_children():
	var node_queue := get_children()
	var states := []
	print(node_queue)
	while node_queue.size() > 0:
		var node = node_queue.pop_front()
		print(node)
		if node is State:
			states.append(node)
		else:
			node_queue.append_array(node.get_children())
	return states
