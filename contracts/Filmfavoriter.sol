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
    status nuvarandeStatus;
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
    }
}






Hani- påbörjat första delen

pragma solidity 0.8.31;

contract FilmFavoriter {
    address public owner;  
    
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
}
}
