public class pickList {
 


public pickList(){}

   @RemoteAction
    public static String getAllObjects() {
        try {
            Boolean typeObj;
            List<String> objList = new List<String>(); 
            Map<String, Schema.SObjectType> GlobalMap = Schema.getGlobalDescribe();
                for (Schema.SObjectType Obj : GlobalMap.values()) {
                     Schema.DescribeSObjectResult ObjDesc = Obj.getDescribe();
                     system.debug('Object Name: ' + ObjDesc.getName());
                     system.debug(ObjDesc.isCustom());
                     if(ObjDesc.isCustom() == typeObj){
                        objList.add(ObjDesc.getName());                        
                     }else{
                        objList.add(ObjDesc.getName()); 
                     }
                 }
                                  return JSON.serialize(objList);
        
        } catch (Exception ex) {
           return JSON.serialize(ex);
        }

        
    }
}