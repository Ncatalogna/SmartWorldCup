pragma solidity ^0.4.2;

import "../contracts/oraclizeAPI_0.5.sol";
import "../installed_contracts/jsmnsol-lib/contracts/JsmnSolLib.sol";

contract SmartBetMatch is usingOraclize {
    address public owner;
    string public urlJsonApiEvent; // example json(https://raw.githubusercontent.com/Ncatalogna/SmartWorldCup/master/data/data.sol.json).knockout.round_2 
    uint256 public minimumBet;
    GameBetDeclare public gameBetDeclare;
    enum Equipo { home_team, away_team }
    enum typeGame { winner, loser}

    struct InGamePlayer {
        address player;
        uint coins;        
        Equipo selectionWinner;
    }

    struct GameBetDeclare {
        string gameInstance;
        Matche matche;        
    }

    struct Matche {
       uint64 name;
       typeGame _type;
       uint64 home_team;
       uint64 away_team;
       uint256 home_result;
       uint256 away_result;
       uint256 home_penalty;
       uint256 away_penalty;
       bool winner;
       uint date;
       uint256 stadium;
       bool finished;
    }

    mapping(address => InGamePlayer) public InGamePlayers;
    mapping(bytes32=>bool) validIds;

    event newOraclizeQuery(string description);

    constructor (string urlApiEventDeclare) public {
        owner = msg.sender;
        urlJsonApiEvent = urlApiEventDeclare;
        update();
    }

    function __callback(bytes32 myid, string result) public  {
        require(msg.sender == oraclize_cbAddress());
        delete validIds[myid];
        updateGameBet(result);      
    }

    function updateGameBet(string result) private {
        uint returnValue;
        JsmnSolLib.Token[] memory tokens;
        uint actualNum;

        (returnValue, tokens, actualNum) = JsmnSolLib.parse(result, 5);

        // Terminar parce con GameBetDeclare
        JsmnSolLib.Token memory t = tokens[2];
        string memory jsonElement = JsmnSolLib.getBytes(result, t.start, t.end);
        
    }

    function update() payable public {
        if (oraclize_getPrice("URL") > this.balance) {
           emit newOraclizeQuery("Oraclize query was NOT sent, please add some ETH to cover for the query fee");
        } else {
           emit newOraclizeQuery("Oraclize query was sent, standing by for the answer..");
           bytes32 queryId = oraclize_query("URL", urlJsonApiEvent);
           validIds[queryId] = true; 
        }
    }

    function kill() public {
        if(msg.sender == owner) selfdestruct(owner);
    }
}
