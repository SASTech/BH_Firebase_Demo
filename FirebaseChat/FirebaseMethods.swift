//
//  FirebaseMethods.swift


import Foundation
import Firebase

class FirebaseMethods {

    var userDetail = NSMutableArray()
    
    //Firebase variables
    var reference:DatabaseReference!
    fileprivate var _refHandle: DatabaseHandle!
    var storageRef: StorageReference!
    var grpMsgRef:DatabaseReference!
    var msgRef :DatabaseReference!
    var logRef:DatabaseReference!
    let dateFormat = ChatDateFormatter()
    
    init(base_url:String,user:String) {
        
        //---- reference of the database----//
        
        reference = Database.database().reference(fromURL: base_url)
        self.msgRef = reference
        self.grpMsgRef = self.msgRef
    }


    
    //MARK:- Fetch last 10 messages from firebase
    
    func fetchMessages(completionHandler:@escaping (_ data:NSMutableArray) -> Void){
        grpMsgRef.child("messages").queryOrderedByKey().observeSingleEvent(of: .value, with: {  (snapshot) -> Void in
            print(snapshot)
            let messages = NSMutableArray()
            for snap in snapshot.children{
                
               messages.add(snap as! DataSnapshot)
            }
            completionHandler(messages)
        })
    }
   
    //MARK:- Fetch total number of messages
    func fetchTotalNumberOfmessages(completionHandler:@escaping (_ data:Int) -> Void){
        grpMsgRef.child("messages").queryOrderedByKey().observe(.value, with: {  (snapshot) -> Void in
            let count = Int(snapshot.childrenCount)
            completionHandler(count)
        })
    }
    
    
    //MARK: Configure message observer to fetch,receive and send messages
    func configureChatDatabase(completionHandler:@escaping (_ data:NSDictionary,_ key:String) -> Void){
        // Listen for new messages in the Firebase database
        _refHandle = grpMsgRef.child("messages").observe(.childAdded, with: {  (snapshot) -> Void in
            print(snapshot)
            completionHandler(snapshot.value as! NSDictionary,"\(snapshot.key)")
        })
        
    }
    
    //MARK:- Configure chat databse to observe change in value of child
    func configurecChatToObserveChange(completionHandler:@escaping (_ data:NSDictionary,_ key:String) -> Void){
        // Listen for new messages in the Firebase database
        
         grpMsgRef.child("messages").observe(.childChanged, with: {  (snapshot) -> Void in
            print(snapshot)
            completionHandler(snapshot.value as! NSDictionary,"\(snapshot.key)")
          
        })
    }
    
    //MARK: Send message to firebase
    func sendMessage(withData data: [String: Any],groupUniqueID:String) {
       
        
        self.msgRef.child("messages").childByAutoId().setValue(data)
        
    }
    
  //MARK:Remove all observer
    func removeAllObservers(){
        if self.grpMsgRef != nil{
            self.grpMsgRef.child("messages").removeAllObservers()
            self.grpMsgRef.removeAllObservers()
            self.grpMsgRef = nil
        }
    }
    

    


    
    
}
