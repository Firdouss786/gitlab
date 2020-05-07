# Overview
Comments section can be added to any model which requires some type of communication between users. It's highly recommended to watch this [video](https://gorails.com/episodes/comments-with-polymorphic-associations) before implementing this feature in your own models. This implementation will work **without** performing any migrations.

### Steps to Add Comments in your Models
1. Include "Commentable Concern" into your model. i.e. `include Commentable`

2. This implementation requires to have a separate Comments Controller for each implementation and to implement this, create a new folder with your model name inside `app/controllers/` directory and then create a new file inside called `comments_controller.rb`. Resulting folder/file structure should look like this: `app/controllers/your_model_name/comments_controller.rb`.

3. Newly created `comments_controller.rb` file should inherit from the actual comments controller like: `class YourModelName::CommentsController < CommentsController`. Contents of this file should follow the exact code from `app/controllers/faults/comments_controller.rb` with the only difference of changing the model name and find attribute accordingly.

4. Add the necessary HTML to your views. A good example can be found at `app/views/faults/show.html.erb`. Remember to update caching and model names accordingly.

5. Finally, add nested route under your model. i.e.
    `resources :your_model_name, shallow: true do
      resources :comments, only: [:create], module: :your_model_name
    end`

### Default Values
By default, author will be recorded as `Current.user` at the time of comment creation. Only the author will be allowed to edit or delete their own comments.

### Comment Table Columns
`id`, `user_id`, `description`, `commentable_type`, `commentable_id`, `created_at`, `updated_at`

** For any further help related to comments section please watch the above referenced video or follow the code from "Fault" comments section.
