pragma solidity 0.8.7;

contract Party {
    //declaration
    /*enum State {reg,attend}
    State public state = State.reg;
    uint startTime;*/
    uint numOfGuest = 0;
    uint numOfReg;
    uint numOfParticipants = 0;
    uint totalMoney = 0;
    address owner;
    struct Table {
        address adders;
        uint money;
    }
    Table[] moneyTable;
    Table[] participants;


    // initiating the owner of the party
    constructor(uint number) public {
        owner = msg.sender;
        //state = State.reg;
        ///startTime = block.timestamp;
        numOfReg = number;
    }

    //guests will pay money and register
    function registration () public payable {
        if (state != State.reg) {return;}
        else if (numOfGuest <= numOfReg) {
                moneyTable[numOfGuest].adders = msg.sender;
                moneyTable[numOfGuest].money = msg.value;
                totalMoney += msg.value;
                numOfGuest ++;
        }
        if (block.timestamp > (startTime+ 50 seconds)) {
                state = State.attend; 
                startTime = block.timestamp;
            }
    }

    //saving guests address
    function partyDay () public {
        if (state != State.attend) {return;}
        else {
                participants[numOfParticipants].adders = msg.sender;
                for (uint i = 0; i < 50; i++) {
                    if(moneyTable[i].adders == msg.sender){
                        participants[numOfParticipants].money = moneyTable[i].money;
                        totalMoney -= moneyTable[i].money;
                        numOfParticipants ++; 
                    }
                }
        }
    }

    //computation and giving rewards
    function reward () public {
        if (msg.sender != owner) {return;}
        else {
            uint additionMoney = totalMoney/numOfParticipants;
            for (uint i = 0; i < numOfParticipants; i++) {
                participants[i].money += additionMoney;
                }
        }
    }
}
