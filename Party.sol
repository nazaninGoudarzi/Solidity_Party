// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Party {
    //declaration
    uint numOfGuest;
    uint numOfReg = 0;
    uint numOfParticipants = 0;
    uint totalMoney = 0;
    address owner;
    struct Table {
        address adders;
        uint money;
    }
    mapping (uint => Table) regPeople;
    mapping (uint => Table) partyPeople;


    // initiating the owner of the party
    constructor(uint number) {
        owner = msg.sender;
        numOfGuest = number;
    }

    //guests will pay money and register
    function registration () external payable {
        require(numOfReg < numOfGuest, 'If you have already registered, you can use the partyDay to participate in the party!');
        if (numOfReg < numOfGuest) {
            //moneyTable[numOfReg].adders = msg.sender;
            //moneyTable[numOfReg].money = msg.value;
            regPeople[numOfReg].adders = msg.sender;
            regPeople[numOfReg].money = msg.value;
            totalMoney += msg.value;
            numOfReg ++;
        }
    }

    //saving guests address
    function partyDay (address participentAddress) public {
        require(numOfParticipants < numOfReg, 'You have not already registered for the party!');
        if (numOfParticipants < numOfReg) {
            partyPeople[numOfParticipants].adders = participentAddress;
            for (uint i = 0; i < numOfGuest; i++) {
                if(regPeople[i].adders == participentAddress){
                    partyPeople[numOfParticipants].money = regPeople[i].money;
                    totalMoney = totalMoney - (regPeople[i].money);
                    numOfParticipants ++; 
                }
            }
        }
    }

    //computation and giving rewards
    function reward (address host) public {
        require(host == owner, 'You are not the host of the party!');
        uint additionMoney = (totalMoney/numOfParticipants);
        for (uint i = 0; i < numOfParticipants; i++) {
            (partyPeople[i].money) += additionMoney;
        }
    }

    //this function is for debugging
    function balenceOf() external view returns (Table[] memory) {
        Table[] memory result = new Table[](numOfParticipants);
        for (uint i = 0; i < numOfParticipants; i++) {
            result[i].adders = partyPeople[i].adders;
            result[i].money = partyPeople[i].money;
        }
        return result;
    }
    //this function enables the contract to receive funds
    receive () external payable {
    }
}
