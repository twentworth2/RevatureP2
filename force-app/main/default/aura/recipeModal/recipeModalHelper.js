({
    searchForRecipe : function(component) {
        var action = component.get("c.searchRecipeById");
        var idVal = component.get("v.recipeID");
        action.setParams({ id : idVal}); 
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
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


    },

    searchForId : function(component) {
        var action = component.get("c.searchRecipeId");
        // params String query, String maxReadyTime, String minCalories, String maxCalories, String includeIngredients
        action.setParams({ query : component.get("v.recipeName")}); 
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var idVal = response.getReturnValue();
                component.set("v.recipeID", idVal);
                this.searchForRecipe(component);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);

    },
})