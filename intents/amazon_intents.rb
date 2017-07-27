require './lib/recipe'

intent "LaunchRequest" do
  response_text = 'Hello Chef. Today, I will be helping you in the kitchen. What would you like to cook? If you tell me an ingredient, I will load some recipes for you. You can provide up to three ingredients. For example, you can say search recipes with chicken, sweet potato, spinach. To select a recipe, please specify the number. You can then ask me for the ingredients and the preparation steps. Say help and I will be right there with you.'
  respond(response_text: response_text)
end

intent "AMAZON.StartOverIntent" do
  response_text = "Starting over... you can either search for a new recipe or end the session."
  respond(response_text: response_text, session_attributes: {} )
end

intent "AMAZON.StopIntent" do
  response_text = "I am always at your assistance. Bon Appétit. Sous Chef successfully ended."
  respond(response_text: response_text, end_session: true)
end

intent "AMAZON.CancelIntent" do
  response_text = "I am always at your assistance. Bon Appétit. Sous Chef successfully ended."
  respond(response_text: response_text, end_session: true)
end

intent "AMAZON.HelpIntent" do
  if request.session_attribute('recipes')
    found_recipes = request.session_attribute('recipes')
    response_text = "Please select the number of the recipe that you would like to cook. #{Recipe.format_response(found_recipes)}"
    respond(response_text: response_text, session_attributes: { recipes: found_recipes })
  elsif request.session_attribute('recipe')
    response_text = "To continue, you can ask me to read the ingredients or the preparation steps. If you would like to choose another recipe, please say start over."
    respond(response_text: response_text, session_attributes: { recipe: request.session_attribute('recipe')})
  else
    respond(response_text: "You can say 'search recipes with' and specify up to three ingredients. Say start over to select different ingredients and/or recipe.")
  end
end
