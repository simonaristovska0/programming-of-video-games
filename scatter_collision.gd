extends Node3D

func _ready():
	for child in get_children():
		if child is MultiMeshInstance3D:
			print("🔎 Пронајден MultiMeshInstance3D:", child.name)
			generate_collision_for_multimesh(child)

func generate_collision_for_multimesh(multimesh_instance):
	var multimesh = multimesh_instance.multimesh
	if not multimesh:
		print("❌ MultiMeshInstance3D нема MultiMesh:", multimesh_instance.name)
		return  

	for i in range(multimesh.instance_count):
		var transform_data = multimesh.get_instance_transform(i)

		# Создаваме StaticBody3D за секоја mesh инстанца
		var static_body = StaticBody3D.new()
		static_body.transform = transform_data

		# **Поставување на Collision Layer и Mask**
		static_body.collision_layer = 1 << 4  # Layer 4 за камења
		static_body.collision_mask = (1 << 3) | (1 << 1)  # Детектира кристали (3) и под (1)

		# Додај StaticBody3D во сцената под `rocks`
		multimesh_instance.add_child(static_body)
		print("✅ StaticBody3D додаден:", static_body)

		# Додавање на CollisionShape3D
		var collision_shape = CollisionShape3D.new()
		var box_shape = BoxShape3D.new()
		box_shape.extents = Vector3(1, 1, 1)  # Прилагоди ја големината
		collision_shape.shape = box_shape

		static_body.add_child(collision_shape)
		print("✅ CollisionShape3D додаден:", collision_shape)
