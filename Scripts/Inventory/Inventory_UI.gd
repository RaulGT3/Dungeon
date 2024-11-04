extends Control

@onready var grid_container = $GridContainer

func _ready():
	# Connect the signal to update and load with correct num of columns
	Global.inventory_updated.connect(_on_inventory_updated)
	_on_inventory_updated()

# Update the inventory UI
func _on_inventory_updated():
	# Clear the current slots
	clear_grid_container()
	
	# Add slots for each inventory item
	for item in Global.inventory:
		# Create new slot and add it to container
		var slot = Global.inventory_slot.instantiate()
		grid_container.add_child(slot)
		if item != null:
			slot.set_item(item)
		else:
			slot.set_empty()

# Clear grid upon each update to ensure correct quantity
func clear_grid_container():
	while grid_container.get_child_count() > 0:
		var child = grid_container.get_child(0)
		grid_container.remove_child(child)
		child.queue_free()