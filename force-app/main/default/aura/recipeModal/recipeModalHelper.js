({
    searchForRecipe : function(component) {
        var action = component.get("c.searchRecipeById");
        var idVal = component.get("v.recipeName.Item_ID__c");
        action.setParams({ id : idVal}); 
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var recipeInfo =  response.getReturnValue();
                console.log(recipeInfo);
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
                console.log(idVal);
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