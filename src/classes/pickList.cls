public class pickList {
    public Boolean typeObj {
        get;
        set;
    }

    public Map<String,String> objMap =  new Map<String,String>(){
        get;
        set;
    }



   @RemoteAction
    public static String getAllObjects() {
        ResponseModel response;

        try {
            Map<String, Schema.SObjectType> GlobalMap = Schema.getGlobalDescribe();
            String labelName; 
                for (Schema.SObjectType Obj : GlobalMap.values()) {
                     Schema.DescribeSObjectResult ObjDesc = Obj.getDescribe();
                     system.debug('Object Name: ' + ObjDesc.getName());
                     system.debug(ObjDesc.isCustom());
                     if(ObjDesc.isCustom() == typeObj){
                        objMap.put(getLable(),getName());
                        la                        
                     }else{
                        objMap.put(getLable(),getName());   
                     }

                 }
                 for  

                 return JSON.serialize(response);
}
        
        } catch (Exception e) {
            SCH_ExceptionHandler.processException(e, NAMESPACE_PREFIX, CLASS_NAME);
            response = new ResponseModel(e.getMessage() + ' ' + e.getStackTraceString(), false);
        }

        return JSON.serialize(response);
    }
}