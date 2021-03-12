public class foodDatabase {
    public foodDatabase() {

    }

    @AuraEnabled
    public static List<String> getSomeFood(String tags){

        //hardcoded for now also need to move the apikey
        String apikey = '56d3e8df4bde46a0b7ca1c01fd344952';
        String title;
        String summary;
        String ingredients;
        String instructions;
        List<String> recipeInfo= new List<String>();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.spoonacular.com/recipes/random?apiKey=' + apikey + '&number=1');//&tags=' + tags); commented out for now cause it was messing with the CPU time
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200){
            recipeInfoJSON info = recipeInfoJSON.parse(response.getBody());
             System.debug(info.recipes[0].title);
           // System.debug(info.recipes[0].summary);
            title = info.recipes[0].title;
            summary = info.recipes[0].summary;
            ingredients = recipeInfoJSON.ExtendedToString(info.recipes[0].extendedIngredients);
            instructions = info.recipes[0].instructions;
            recipeInfo.add(title);
            recipeInfo.add(summary);
            recipeInfo.add(ingredients);
            recipeInfo.add(instructions);

        }
        
        return recipeInfo;
    }

    @AuraEnabled
    public static List<Recipe__c> searchRecipeNames(String query, String maxReadyTime, String minCalories, String maxCalories){
        //hardcoded for now also need to move the apikey
        String apikey = '56d3e8df4bde46a0b7ca1c01fd344952';
        recipeList listOfRecipes;
        List<Recipe__c> recipeNames = new List<Recipe__c>();
        String queryBuilder = '';

        if(query != '')
        {
            queryBuilder = queryBuilder + '&query=' + query;
        }

        if(maxReadyTime != '')
        {
            queryBuilder = queryBuilder + '&maxReadyTime=' + maxReadyTime;
        }

        if(minCalories != '')
        {
            queryBuilder = queryBuilder + '&minCalories=' + minCalories;
        }

        if(maxCalories != '')
        {
            queryBuilder = queryBuilder + '&maxCalories=' + maxCalories;
        }

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.spoonacular.com/recipes/complexSearch?apiKey=' + apikey + queryBuilder);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200){
            listOfRecipes = recipeList.parse(response.getBody());
             System.debug(listOfRecipes.number_Z);
            for (Integer i = 0; i < listOfRecipes.number_Z; i++){
                Recipe__c item = new Recipe__c();
                item.Name = listOfRecipes.results[i].title;
                item.item_ID__c = listOfRecipes.results[i].id;
                recipeNames.add(item);
                System.debug(item.Item_ID__c + ' ' + item.Name);
            }
        }
        
        System.debug(recipeNames);
        return recipeNames;
    }

    @AuraEnabled
    public static Integer searchRecipeId(String query){
        //hardcoded for now also need to move the apikey
        String apikey = '56d3e8df4bde46a0b7ca1c01fd344952';
        recipeList listOfRecipes;
        Integer recipeId;
        String queryBuilder = '&number=1';

        if(query != '')
        {
            queryBuilder = queryBuilder + '&query=' + query;
        }

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.spoonacular.com/recipes/complexSearch?apiKey=' + apikey + queryBuilder);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200){
            listOfRecipes = recipeList.parse(response.getBody());
            recipeId = listOfRecipes.results[0].id;
        }
        
        System.debug('got id' + recipeId);
        return recipeId;
        
    }

    @AuraEnabled
    public static List<String> searchRecipeById(Integer id){
        //hardcoded for now also need to move the apikey
        String apikey = '56d3e8df4bde46a0b7ca1c01fd344952';
        String title;
        String summary;
        String ingredients;
        String instructions;
        List<String> recipeInfo = new List<String>();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //https://api.spoonacular.com/recipes/716429/information?apiKey=56d3e8df4bde46a0b7ca1c01fd344952
        request.setEndpoint('https://api.spoonacular.com/recipes/' + id + '/information?apiKey=' + apikey);
        System.debug('https://api.spoonacular.com/recipes/' + id + '/information?apiKey=' + apikey);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200){
            singularRecipe info = singularRecipe.parse(response.getBody());
            title = info.title;
            summary = info.summary;
            ingredients = singularRecipe.ExtendedToString(info.extendedIngredients);
            instructions = info.instructions;
            System.debug(info.title);
            recipeInfo.add(info.title);
            recipeInfo.add(summary);
            recipeInfo.add(ingredients);
            recipeInfo.add(instructions);
        }
        
        return recipeInfo;
    }

    @AuraEnabled
    public static Recipe__c saveRecipe (String r) {
    Recipe__c strsRecord = (Recipe__c)JSON.deserialize(r,Recipe__c.class);
    insert strsRecord;
    // View its content, including ID (null until it's inserted)
    //system.debug( r );
    // Display a URL which you can cut and paste into your browser to see the detail page for the inserted object
   // String urlForDetailPage = new PageReference('/' + r.id).getUrl();
   // system.debug( urlForDetailPage );
    return strsRecord;
}
}