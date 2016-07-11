public class productCtrl{
    public Product__c product {
        get;
        set;
    }
    public  String searchText {
        get;
        set;
    }
    public  String selectedProductId {
        get;
        set;
    }
    public List<Product__c> productList {
        get;
        set;
    }
    
    
    public  String sortFieldSave{
        get {
        if (sortFieldSave== null) {
                    sortFieldSave = 'name_product__c';
                }
        return sortFieldSave; 
            }
        set;
        }
    
    public String sortDirection {
        get { 
        if (sortDirection == null) {
                  sortDirection = 'asc'; 
              } 
          return sortDirection ;  
            }
        set;
    }
    
    public String sortField {
        get {
         if (sortField == null) {
         SortField = 'name_product__c'; 
            }
          return sortField ;  
          }
        set;
    }    

    
    public productCtrl(){
        this.product = new Product__c();
        total_size = [select count() from Product__c]; //set the total size in the constructor 
        sortToggle();
    }
    
   
    
       
    public void getListSize(){
        total_size = [select count() from Product__c];
    }
    
    public void deletenote(){ 
         productList = [SELECT Id FROM Product__c WHERE Id = :selectedProductId ]; 
         delete productList;
         sortToggle();
         getListSize();
   
    }

    public void sortToggle() {
        String newSearch= '\'%' + searchText + '%\'';
         System.debug(newSearch);
         String test = '\'%' +'null'+ '%\'';
         System.debug(test);
        sortDirection = sortDirection.equals('asc') ? 'desc NULLS LAST' : 'asc';
        if (sortFieldSave != sortField ) {
            sortDirection = 'asc';
            sortFieldSave = sortField ;
            }
        String querystr = '';
        if(newSearch.equals(test)){
             querystr +='SELECT Id,Date_added__c,in_stock__c,name_product__c,Price__c,Quantity__c,Release_date__c,Type_product__c FROM Product__c ORDER BY';
        }else{
             
             querystr += 'SELECT Id,Date_added__c,in_stock__c,name_product__c,Price__c,Quantity__c,Release_date__c,Type_product__c FROM Product__c WHERE name_product__c LIKE ';
             querystr += newSearch;
             querystr += ' ORDER BY';
             newSearch = test;
             }
        String pagination = 'limit :list_size offset :counter';
             querystr += ' ';
             querystr += sortFieldSave;
             querystr += ' ';
             querystr += SortDirection;
             querystr += ' ';
             querystr += pagination;
             System.debug(querystr);
             productList = database.query(querystr);
        
         }
    
   public integer counter=0;  //keeps track of the offset
   public integer list_size=5; //sets the page size or number of rows
   public integer total_size; //used to show user the total size of the list
     
     public PageReference Save(){
     
     try{
       insert this.product;
       this.product = new Product__c();
       sortToggle();
       getListSize();
       }
       
    catch(Exception ex){
        ApexPages.addMessages(ex);
        sortToggle();
        getListSize();
        }
        return null;
      
    }
     
 
      public PageReference Beginning() { //user clicked beginning
      counter = 0;
      sortToggle();
      return null;
     
      
   }
 
   public PageReference Previous() { //user clicked previous button
      counter -= list_size;
      sortToggle();
      return null;
      
   }
 
   public PageReference Next() { //user clicked next button
      counter += list_size;
     
      sortToggle();
      return null;
   }
 
   public PageReference End() { //user clicked end
      counter = total_size - math.mod(total_size, list_size);
      sortToggle();
      return null;
      
   }
 
   public Boolean getDisablePrevious() { 
      //this will disable the previous and beginning buttons
      if (counter>0) return false; else return true;
     
   }
 
   public Boolean getDisableNext() { //this will disable the next and end buttons
      if (counter + list_size < total_size) return false; else return true;
     
   }
 
   public Integer getTotal_size() {
      return total_size;
      
   }
 
   public Integer getPageNumber() {
      return counter/list_size + 1;
      
   }
 
   public Integer getTotalPages() {
      if (math.mod(total_size, list_size) > 0) {
         return total_size/list_size + 1;
      } else {
         return (total_size/list_size);
      }
      
   }   
}