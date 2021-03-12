({
    openModel: function(component, event, helper) {
       // Set isModalOpen attribute to true
       helper.searchForId(component);
       component.set("v.isModalOpen", true);
    },
   
    closeModel: function(component, event, helper) {
       // Set isModalOpen attribute to false  
       component.set("v.isModalOpen", false);
    },
   
    submitDetails: function(component, event, helper) {
       // Set isModalOpen attribute to false
           var newRec = component.get("v.newRecipe");
           var copy = newRec;
           delete copy.Id;

           copy.name = component.get("v.recipeName");
           copy.instructions__c = component.get("v.recipeInstructions");
           copy.ingredients__c = component.get("v.recipeIngredients");

           var action = component.get("c.saveRecipe");
           action.setParams({ 
            "r": JSON.stringify(copy) 
        });
           action.setCallback(this, function(response) {
                  var state = response.getState();
                   if (state === "SUCCESS") {
                      console.log(newRec.name);
                   }
                   else {
                     console.log("Failed with state: " + state);
                 }
               });
           $A.enqueueAction(action)
       component.set("v.isModalOpen", false);
    },
 })