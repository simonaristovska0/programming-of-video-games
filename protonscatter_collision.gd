#extends Node3D
#
#func _ready():
	#for scatter_item in get_children():
		#if scatter_item is Node3D:  # Make sure it's a valid object
			#var static_body = StaticBody3D.new()
			#scatter_item.add_child(static_body)
			#static_body.owner = owner  # Ensures it saves in the scene
#
			#var collision_shape = CollisionShape3D.new()
			#static_body.add_child(collision_shape)
			#collision_shape.owner = owner  # Ensures it saves in the scene
#
			## Assign a shape (Box for simple objects, Convex for complex ones)
			#var shape = BoxShape3D.new()  # You can change this to another shape if needed
			#collision_shape.shape = shape
#
			## Fit the shape to the mesh (Optional, adjust manually if needed)
			#var mesh_instance = scatter_item.get_node_or_null("MeshInstance3D")
			#if mesh_instance:
				#var aabb = mesh_instance.get_aabb()
				#shape.size = aabb.size  # Make the box the same size as the mesh
