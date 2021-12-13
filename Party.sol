pragma solidity 0.8.7;

contract Party {
    //declaration
    enum State {reg,attend}
    State public state;
    uint numOfGuest;
    uint numOfReg = 0;
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
        state = State.reg;
        numOfGuest = number;
    }

    //guests will pay money and register
    function registration (address regAddress , uint regMoney) public payable {
        if (state != State.reg) {return;}
        else if (state == State.reg && numOfReg <= numOfGuest) {
            moneyTable[numOfGuest].adders = regAddress;
            moneyTable[numOfGuest].money = regMoney;
            totalMoney += regMoney;
            numOfGuest ++;
        }
        else if (numOfReg > numOfGuest) {
            state = State.attend;
        }
    }

    //saving guests address
    function partyDay (address participentAddress) public {
        if (state != State.attend) {return;}
        else if (state == State.attend && numOfParticipants <= numOfReg) {
            participants[numOfParticipants].adders = participentAddress;
            for (uint i = 0; i < numOfGuest; i++) {
                if(moneyTable[i].adders == participentAddress){
                    participants[numOfParticipants].money = moneyTable[i].money;
                    totalMoney -= moneyTable[i].money;
                    numOfParticipants ++; 
                }
            }
        }
        else if (numOfParticipants > numOfReg) {return;}
    }

    //computation and giving rewards
    function reward (address host) public {
        if (host != owner) {return;}
        else {
            uint additionMoney = totalMoney/numOfParticipants;
            for (uint i = 0; i < numOfParticipants; i++) {
                participants[i].money += additionMoney;
                }
        }
    }

    // this function enables the contract to receive funds
    receive() external payable {
    }
}
