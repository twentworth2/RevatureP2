({
    
    searchFoodNameHelper : function(component) {
        var action = component.get("c.searchRecipeNames");
        // params String query, String maxReadyTime, String minCalories, String maxCalories, String includeIngredients
        action.setParams({ query : component.get("v.recipeQuery"), maxReadyTime :  component.get("v.recipeMaxReadyTime"),  minCalories :  component.get("v.recipeMinCalories"), maxCalories :  component.get("v.recipeMaxCalories")}); 
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var recipeInfo =  response.getReturnValue();
                component.set("v.recipeNames", recipeInfo);
                console.log(recipeInfo);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);

    }
})
