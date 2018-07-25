pragma solidity ^0.4.0;
pragma experimental ABIEncoderV2;

contract Dudeschatz
{
    struct Message
    {
        address from;
        address to;
        string[] msg;
        uint[] time;
        
    }
    
    mapping(address=>mapping(address=>Message))Chat;
    
    struct Follower
    {
        address[] followlist;
        uint[] ftime;
    }
    
    mapping(address=>Follower)Follow;
    
    
    
    struct Post
    {
       bytes[] Msgs;
        uint[] Ptime;
        
    }
    
    mapping(address=>mapping(address=>Post)) PostDB;
    
    function chat(address _to,string _msg)public returns(bool)
    {
        Chat[msg.sender][_to].from = msg.sender;
        Chat[msg.sender][_to].to = _to;
        Chat[msg.sender][_to].msg.push(_msg);
        Chat[msg.sender][_to].time.push(now);
        return true;
    }
    
    
    
    
    function MsgDB(address to)public view returns(string[],uint[])
    {
        return (Chat[msg.sender][to].msg,Chat[msg.sender][to].time);
    }
    
    
    
    function followers(address Viewer)public 
    {
        Follow[msg.sender].followlist.push(Viewer);
        Follow[msg.sender].ftime.push(now);
    }
    
    
    function SelfFollowList()public view returns(address[],uint[])
    {
        return (Follow[msg.sender].followlist,Follow[msg.sender].ftime);
    }
    
    
    function forPost(bytes _PMsg)public  returns(bool)
    {
        uint k =Follow[msg.sender].followlist.length;
        
        while(k!=0)
        {
            address ss = Follow[msg.sender].followlist[k];
            PostDB[msg.sender][ss].Msgs.push(_PMsg);
            PostDB[msg.sender][ss].Ptime.push(now);
            k--;
            
        }
        
        return true;
    }
    
    function forDisplayPost(address _dfollow)public view returns(bytes[],uint[])
    {
        
         return (PostDB[msg.sender][_dfollow].Msgs,PostDB[msg.sender][_dfollow].Ptime);
         
    }
    
    
}
