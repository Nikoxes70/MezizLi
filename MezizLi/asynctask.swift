import Foundation
/**
*Defines a task which executed asynchronously in background thread.
*Every AsyncTask instance has 3 life cycle events:
* 1. beforeTask execution (Optional) - executed on UI Main thread
* 2. bagkroundTask execution - executed in background thread
* 3. afterTask execution (Optional) - executed on UI Main thread
*
*When caller instantiates AsyncTask he\she can decide what data type to pass in and out, using 
* predefined generic types <BGParam,BGResult> where
* BGParam - passed in to 'backgroundTask' from calling 'execute' method
* BGResult - passed out from 'backgroundTask' to 'afterTask' method
*
*Usage examples:
*
* //Example 1
*   AsyncTask(backgroundTask: {(p:String)->() in
*     print(p);
*   }).execute("Hello async");
*
* //Example 2
*   let task=AsyncTask(beforeTask: {
*       print("pre execution");
*   },backgroundTask: {(p:Int)->String in
*      if p>=0{return "Positive";}
*      else {return "Negative";}
*   }, afterTask: {(p:String)in
*      print("\(p)");
*   });
*   task.execute("Bubu");
*
*/
public class AsyncTask <BGParam,BGResult>{
    private var pre:(()->())?;//Optional closure -> called before the backgroundTask
    private var bgTask:(param:BGParam)->BGResult;//background task
    private var post:((param:BGResult)->())?;//Optional closure -> called after the backgroundTask
    /**
    *@param beforeTask Optional closure -> which called just before the background task
    *@param backgroundTask closure -> the background task functionality with generic param & return
    *@param afterTask Optional -> which called just after the background task
    */
    public init(beforeTask: (()->())?=nil, backgroundTask: (param:BGParam)->BGResult, afterTask:((param:BGResult)->())?=nil){
        self.pre=beforeTask;
        self.bgTask=backgroundTask;
        self.post=afterTask;
    }
    /**
    *Execution method for current backgroundTask with given parameter value in background thread.
    *@param BGParam passed as a parameter to backgroundTask
    */
    public func execute(param:BGParam){
        pre?()//if beforeTask exists - invoke it before bgTask
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
            let bgResult=self.bgTask(param: param);//execute backgroundTask in background thread
            if(self.post != nil){//if afterTask exists - invoke it in UI thread after bgTask
                dispatch_async(dispatch_get_main_queue(),{self.post!(param: bgResult)});
            }
        });
    }
}