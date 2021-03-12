({
    getRandomRecipe : function(component) {
        var action = component.get("c.getSomeFood");
      //  action.setParams({ tags : component.get("v.recipeTags") }); holding off on tags for now
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(response.getReturnValue());
                var recipeInfo =  response.getReturnValue();
                component.set("v.recipeName", recipeInfo[0]);
                component.set("v.recipeSummary", recipeInfo[1]);
                component.set("v.recipeIngredients", recipeInfo[2]);
                component.set("v.recipeInstructions", recipeInfo[3]);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);

    }
})