pragma solidity ^0.4.25;
pragma experimental ABIEncoderV2;

contract Voter {
    
    struct OptionPos {
        uint pos;
        bool exist;
    }
    
    
    uint[] public votes;
    string[] public options;
    mapping (address => bool) hasVoted;
    mapping (string => OptionPos) posOfOption;

    constructor (string[] _options) public {
        options = _options;
        votes.length = options.length;
        
        for(uint i = 0; i < options.length; i++) {
            OptionPos memory optionPos = OptionPos(i, true);
            string optionName = options[i];
            posOfOption[optionName] = optionPos;
        }
        
    }
    
    function vote(uint option) public {
        require(0 <= option && option < options.length, "Invalid option");
        require(!hasVoted[msg.sender], "Account has already voted");
        
        votes[option] = votes[option] + 1;
        hasVoted[msg.sender] = true;
        
    }
    
    function vote(string optionName) public {
        require(!hasVoted[msg.sender], "Account has already voted");
        
        OptionPos memory optionPos = posOfOption[optionName];
        require(optionPos.exist, "Option does not exist");
        
        votes[optionPos.pos] = votes[optionPos.pos] +1;
        hasVoted[msg.sender] = true;
        
    }
    function getOptions() public view returns( string[]) {
        return options;
        
    }
    
    function getVotes() public view returns(uint[]) {
        return votes;
    }
}
