// SPDX-License-Identifier: MIT 
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract Election {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    // Store accounts that voted
    mapping(address => bool) public voters;

    // Store Candidates
    mapping(uint => Candidate) public candidates;

    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor () public{
        addCandidate("Anies Baswedan");
        addCandidate("Prabowo Subianto");
        addCandidate("Ganjar Pranowo");
    }

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        //they haven't voted before
        require(!voters[msg.sender]);

        //valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record voter that voted
        voters[msg.sender] = true;

        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}
