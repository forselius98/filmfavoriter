// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.31; 

//--Utveckla ett kontrakt där användare kan rösta på sin favoritfilm från en lista. Röstningen ska vara öppen under en viss tid, och därefter räknas rösterna för att utse en vinnare. Kontraktet ska ha funktioner för att skapa en omröstning, starta röstningen, lägga en röst, och räkna rösterna. När en röstning är avslutad ska den vinnande filmen presenteras. Varje omröstning ska vara kopplad till den användare som skapade den.--//

//[]Kontraktet ska innehåll följande element:
// Minst en struct eller enum
// Minst en mapping eller array
// En constructor
// Minst en custom modifier
// Minst ett event för att logga viktiga händelser
// Minst ett custom error
// Minst en require, en assert, och en revert
// En fallback och/eller receive funktion

contract filmFavoriter { 
  
  struct Omrostning {
    string title;
    address skapare;
    uint16 slutTid;
    string[] filmAlternativ;
    mapping(string => uint16) rostAntal;
    mapping(address => bool) harRostat;
  }
  //-state variabel--
    Omrostning public omrostning;
    address public owner;

    //-Event--
    event RostLagd(address valjare, string film);
    event OmrostningStartad(uint16 slutTid);
    event VinnarePresenterad(string vinnandeFilm, uint16 antalRoster);

    //-Custom error-- 
    error EndastSkapare();
    error RedanRostat();
    error OmrostningEjAktiv();

    //--Modifiers---
    modifier endastSkapare() {
        if (msg.sender != omrostning.skapare) revert EndastSkapare();
        _;
    }

    modifier arPagaende() {
        require(block.timestamp < omrostning.slutTid, "Tiden har gatt ut");
        require(omrostning.nuvarandeStatus = Status.Pagaende, "Omrostning ar inte aktiv");
    }

    constructor() {
        owner = msg.sender;
    }

    function filmAlternativ(string memory) public {
        
    }
}






//Hani- påbörjat första delen

pragma solidity 0.8.31;

contract FilmFavoriter {
    address public owner;  
    
    //--  struct Omrostning {
    string title;
    address skapare;
    uint16 slutTid;
    string[] filmAlternativ;
    mapping(string => uint16) rostAntal;
    mapping(address => bool) harRostat;
  }
    struct Vote {
        string titel;
        uint vote; 
        address delegate;
    }
    
    Vote[5] public votes;
    uint public voteCount = 0;  
    mapping(address => Vote[5]) public polls;  
    
    constructor() {  
        owner = msg.sender;
    }
    
    function createPoll() public {  
        
    }

//------Elli--------
    // SPDX-License-Identifier: SEE LICENSE IN LICENSE
    pragma solidity 0.8.31;

    contract movieF1 {
        struct Voter {
        bool voted; //Om sant, har personen redan röstat
        uint vote; // Index för den valda filmen 
        }

        struct Movie {
            bytes32 name; //Kort namn för filmen 
            uint voteCount; //Antal under tid
        }

        //State variabler
        address public creator;
        uint256 public votingDeadline;
        bool public votingStarted;

        mapping(address => Voter) public voters;
        Movie[] public movies;

        // --- Custom Errors ---
        error OnlyCreator();
        error AlreadyVoted();
        error VotingNotActive();

        // --- Events ---
        event VoteCast(address indexed voter, uint movieIndex);
        event VotingOpened(uint256 deadline);

        // --- Custom Modifier ---
        modifier onlyCreator() {
        if (msg.sender != creator) revert OnlyCreator();
        _;
    }
        constructor(bytes32[] memory movieNames) {
        creator = msg.sender;
        currentStatus = Status.Skapad;

        for (uint i = 0; i < movieNames.length; i++) {
            movies.push(Movie({
                name: movieNames[i],
                voteCount: 0
            }));
        }
    }

    function startVoting(uint durationInMinutes) external onlyCreator {
        require(currentStatus == Status.Skapad, "Already started");
        
        currentStatus = Status.Aktiv;
        votingDeadline = block.timestamp + (durationInMinutes * 1 minutes);
        
        emit VotingOpened(votingDeadline);
    }

    function vote(uint movieIndex) external {
        if (currentStatus != Status.Aktiv || block.timestamp > votingDeadline) {
            revert VotingNotActive();
        }
        if (voters[msg.sender].voted) {
            revert AlreadyVoted();
        }

    }
 }















//------Hani--------
   // SPDX-License-Identifier: MIT
pragma solidity ^0.8.31;

contract FilmFavoriter {
    address public owner;  
    
    enum Status { Inactive, Active, Ended }
    
    struct Poll {
        string[] movies;
        uint256[] votes; 
        uint256 endTime;
        Status status;
        address owner;
    }
    
    mapping(address => Poll) public userPolls;
    
    constructor() {
        owner = msg.sender;
    }

    modifier isOwner() {
    require(msg.sender == owner, "Caller is not owner");
    _;

}

//Event
event PollStarted(address indexed  creator, string[] movies);
event VoteCast(address indexed voter, uint256 movieIndex);
event PollEnded(address indexed creator, uint256 winnerIndex);

//Error
error PollNotActive(string status);  // ← STOPP-KNAPPEN!

//Function
    function createPoll(string[] memory _movies, uint256 _duration) public isOwner {
        require(_movies.length >= 2, "Minst 2 filmer");  
        uint256[] memory emptyVotes = new uint256[](_movies.length);
        userPolls[msg.sender] = Poll({
            movies: _movies,
            votes: emptyVotes,
            endTime: block.timestamp + _duration,
            status: Status.Active,
            owner: msg.sender
        });
        emit PollStarted(msg.sender, _movies);
    }

    function vote(uint256 _movieIndex) public {
        Poll storage poll = userPolls[msg.sender];
        if (poll.status != Status.Active) {
            revert PollNotActive("Inactive");
        }
        require(block.timestamp < poll.endTime, "Poll slut");
        require(_movieIndex < poll.movies.length, "Fel film!");
        poll.votes[_movieIndex] += 1;
        emit VoteCast(msg.sender, _movieIndex);
    }

    function endPoll() public isOwner {
        Poll storage poll = userPolls[msg.sender];
        require(block.timestamp >= poll.endTime, "Poll inte slut");
        assert(poll.owner == msg.sender);
        poll.status = Status.Ended;
        emit PollEnded(msg.sender, 0);
    }

    function getWinnerIndex(address _user) public view returns (uint256) {
        Poll storage poll = userPolls[_user];
        uint256 winner = 0;
        for (uint256 i = 1; i < poll.votes.length; i++) {
            if (poll.votes[i] > poll.votes[winner]) {
                winner = i;
            }
        }
        return winner;
    }

    fallback() external payable {
        revert("Inga fallback calls");
    }

    receive() external payable {}
}
