extends Resource
class_name RecipeResource

@export var inputs: Array[ItemResource]
@export var output: ItemResource

static func sort_by_name(a: ItemResource, b: ItemResource) -> bool:
		return a.name < b.name
