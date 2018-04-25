pragma solidity ^0.4.2;

import "../contracts/SafeMath.sol";
import "../contracts/Owner.sol";
import "../contracts/SmartBetMatch.sol";

contract SmartWorldCup {
    address private owner;
    mapping(address => SmartBetMatch) public smartBetMatchList;
    

    // The address of the player and => the user info   
        
    function SmartWorldCup() public {
        owner = msg.sender;
    }
    
    function NewBetMatch() public {
        if(msg.sender == owner){
            
        }
    
    }
}
