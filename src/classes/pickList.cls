public class pickList {
    Boolean typeObj {
        get;
        set;
    }

    public pickList(){}

   @RemoteAction
    public static String getAllObjects(Boolean typeObj) {
        try {
            String[] objList = new String[] {};
            Map<String, Schema.SObjectType> GlobalMap = Schema.getGlobalDescribe();
                for (Schema.SObjectType Obj : GlobalMap.values()) {
                     Schema.DescribeSObjectResult ObjDesc = Obj.getDescribe();
                     system.debug('Object Name: ' + ObjDesc.getName());
                     system.debug(ObjDesc.isCustom());
                     if(ObjDesc.isCustom() == typeObj){
                        objList.add(ObjDesc.getName());                     
                     }
                        system.debug(objList);    
                 }
                                  return JSON.serialize(objList);
        
        } catch (Exception ex) {
           return JSON.serialize(ex);
        }

        
    }
}