# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) | User has_many Restaurants, User has_many Foods
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User) | Restaurant belongs_to User, Restaurant belongs_to User
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients) | Restaurants has_many Foods through Restaurant_Foods, Foods has_many Restaurants through Restaurant_Foods
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity) | restaurant_foods.price
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item) | Food, Restaurant, and Restaurant_Food have validations
- [ ] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
- [x] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item) | users/1/restaurants/new, Food
- [x] Include signup (how e.g. Devise) | Devise
- [x] Include login (how e.g. Devise) | Devise
- [x] Include logout (how e.g. Devise) | Devise
- [x] Include third party signup/login (how e.g. Devise/OmniAuth) | Github
- [x] Include nested resource show or index (URL e.g. users/2/recipes) | users/1/restaurants, users/1/foods
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients) | users/1/restaurants/new, users/1/foods/new
- [x] Include form display of validation errors (form URL e.g. /recipes/new) | Errors are on top of form

Confirm:
- [ ] The application is pretty DRY
- [ ] Limited logic in controllers
- [ ] Views use helper methods if appropriate
- [ ] Views use partials if appropriate
