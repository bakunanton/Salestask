public class pickList {

    public pickList(){}

    @RemoteAction
    public static String getAllObjects(Boolean typeObj) {
        try {
            String[] objList = new String[] {};
            Map<String, Schema.SObjectType> globalMap = Schema.getGlobalDescribe();
            for (Schema.SObjectType Obj : globalMap.values()) {
                Schema.DescribeSObjectResult objDesc = obj.getDescribe();
                system.debug('Object Name: ' + objDesc.getName());
                system.debug(objDesc.isCustom());
                if ( objDesc.isCustom() == typeObj) {
                    objList.add(objDesc.getName());                     
                }
                System.debug(objList);    
            }
            return JSON.serialize(objList);
        } catch (Exception ex) {
           return JSON.serialize(ex);
        }

        
    }

    @RemoteAction
    public static String getAllFieldsList(String nameObject) {
        try {
            String[] objFieldApiName = new String[] {};
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Schema.SObjectType leadSchema = schemaMap.get(nameObject);
            Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
            for (String fieldName: fieldMap.keySet()) { 
                System.debug(fieldName); 
                objFieldApiName.add(fieldName);
                //It provides to get the object fields label.
                //String fieldLabel = fieldMap.get(fieldName).getDescribe().getLabel();
        }
            return JSON.serialize(objFieldApiName);
        } catch (Exception ex) {
           return JSON.serialize(ex);
        }
    }


    @RemoteAction
    public static String getFieldsRec(String nameObject, String nameField) {
        try {
            System.debug(nameObject);
            System.debug(nameField);
            List<SObject> fieldRec = new List<SObject>();
            String[] recordField = new String[] {};
            String que ='SELECT ' + nameField + ' FROM ' + nameObject;
            fieldRec = Database.query(que);
            System.debug(fieldRec);
            return JSON.serialize(fieldRec);
            //List<Object> objFieldApiName = new List<Object>();
            //Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            //Schema.SObjectType leadSchema = schemaMap.get(nameObject);
            //Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
            //for (String fieldName: fieldMap.keySet()) { 
            //    System.debug(fieldName); 
            //    objFieldApiName.add(fieldName);
            //}
            //String fields = String.join(objFieldApiName, ',');
            //List<SObject> fieldRec = new List<SObject>();
            //String query = 'SELECT ' + fields + ' FROM ' + nameObject;
            //System.debug(query);
            //fieldRec = Database.query(query);
            //System.debug(fieldRec);
            //return JSON.serialize(fieldRec);
        } catch (Exception ex) {
           return JSON.serialize(ex);
        }
    }

    @RemoteAction
    public static String getSortlist(String nameObject, String nameField, String nameSorttogle, String searchIn) {
        try {
            System.debug(searchIn);
            String numberPage = '1';
            List<Object> objFieldApiName = new List<Object>();
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Schema.SObjectType leadSchema = schemaMap.get(nameObject);
            Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
            for (String fieldName: fieldMap.keySet()) { 
                System.debug(fieldName); 
                objFieldApiName.add(fieldName);
            }
            String fields = String.join(objFieldApiName, ',');
            Integer listSize = 7;
            List<SObject> fieldRec = new List<SObject>();
            System.debug('before Sooql query');
            if (searchIn.equals('null')) {
                String query = 'SELECT ' + fields + ' FROM ' + nameObject + ' ORDER BY ' + nameField + ' ' + nameSorttogle + ' LIMIT ' + listSize + ' OFFSET ' + numberPage; 
                fieldRec = Database.query('no search:' + query);
            } else {
                String query = 'SELECT ' + fields + ' FROM ' + nameObject + ' WHERE ' + nameField +' LIKE ' + '\'%' + searchIn + '%\'' + ' ORDER BY ' + nameField + ' ' + nameSorttogle + ' LIMIT ' + listSize + ' OFFSET ' + numberPage;
                System.debug('with search:' + query);
                fieldRec = Database.query(query);
            }
            System.debug('after sooql:' + searchIn);         
            System.debug(fieldrec);
            return JSON.serialize(fieldRec);
        } catch(Exception ex) {
           return JSON.serialize(ex);
        }

    }
}