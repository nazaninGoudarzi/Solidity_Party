pragma solidity 0.8.7;

contract Party {
    enum State {reg,attend}
    State public state = State.reg;
    mapping(address => uint) moneyTable;
    uint startTime;
    uint numOfGuest = 50;
    address owner;
    address[] guests;

    //event declaration
    event stateChange (State);

    // initiating the owner of the party
    constructor() public {
        owner = msg.sender;
        state = State.reg;
        startTime = block.timestamp;
    }

    //guests will pay money and register
    function registration () public payable {
        if (block.timestamp > (startTime+ 10 seconds)) {
                state = State.attend; 
                startTime = block.timestamp;
            }
        if (state != State.reg) {return;}
        else {
                moneyTable[msg.sender] = msg.value;
        }
        if(state == State.attend) {
                emit stateChange (state);
        }
    }

    //saving guests address
    function partyDay () public {
        if (state != State.attend) {return;}
        else {
                guests = [msg.sender];
        }
    }

    //computation and giving rewards
    function reward () internal {
        if (msg.sender != owner) {return;}
        else {
                for (uint i = 0; i < 50 ; i++) {
                    
                }
        }
    }
}