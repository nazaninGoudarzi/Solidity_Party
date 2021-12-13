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
    Table[] moneyTable;
    Table[] participants;


    // initiating the owner of the party
    constructor(uint number) {
        owner = msg.sender;
        numOfGuest = number;
    }

    //guests will pay money and register
    function registration () external payable {
        require(numOfReg < numOfGuest, 'If you have already registered, you can use the partyDay to participate in the party!');
        if (numOfReg < numOfGuest) {
            moneyTable[numOfGuest].adders = msg.sender;
            moneyTable[numOfGuest].money = msg.value;
            totalMoney += msg.value;
            numOfReg ++;
        }
    }

    //saving guests address
    function partyDay (address participentAddress) public {
        require(numOfParticipants < numOfReg, 'You have not already registered for the party!');
        if (numOfParticipants < numOfReg) {
            participants[numOfParticipants].adders = participentAddress;
            for (uint i = 0; i < numOfGuest; i++) {
                if(moneyTable[i].adders == participentAddress){
                    participants[numOfParticipants].money = moneyTable[i].money;
                    totalMoney -= moneyTable[i].money;
                    numOfParticipants ++; 
                }
            }
        }
    }

    //computation and giving rewards
    function reward (address host) public {
        require(host == owner, 'You are not the host of the party!');
        uint additionMoney = totalMoney/numOfParticipants;
        for (uint i = 0; i < numOfParticipants; i++) {
            participants[i].money += additionMoney;
        }
    }

    // this function enables the contract to receive funds
    receive () external payable {
    }
}
