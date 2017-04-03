# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) (user has_many notifications, etc.)
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User) (comment belongs_to task, etc.)
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients) (task has_many labels, through labels_tasks)
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity) (I don't _technically_ have one of these, but assistant-role users have many tasks by policy-scoping through client-role users (same with reminders) and those are pretty much just manually specified "has_many, through" relationships, and arguably a lot more complex... my point being that I _do_ understand this relationship, I just built the application before seeing the spec and this one is not explicitly part of the README instructions)
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item) (User, Comment, Label, Notification, Reminder, Task)
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes) (see any model except Label/LabelsTask for use of class-level scopes, see left sidebar at any URL for Notification.viewing_order as an example, policies define more complex scopes as well)
- [x] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item) (/tasks, Label ("more labels" comma-separated textbox in new task form at top when signed in as a client))
- [x] Include signup (how e.g. Devise) (rolled my own)
- [x] Include login (how e.g. Devise) (rolled my own)
- [x] Include logout (how e.g. Devise) (rolled my own)
- [x] Include third party signup/login (how e.g. Devise/OmniAuth) (omniauth, omniauth-facebook-omniauth, and omniauth-google_oauth2 gems)
- [x] Include nested resource show or index (URL e.g. users/2/recipes) (/users/3/tasks as long as you're signed in as user 3 or that user's assistant)
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients) (/users/3/reminders/new as long as you're signed in as user 3's assistant)
- [x] Include form display of validation errors (form URL e.g. /recipes/new) (/signup, /tasks new task form if you're a client, /users/:id/reminders/new if you're an assistant, /tasks/:id new comment form, /labels/new)

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
