// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.31;

//Kontraktet ska innehåll följande element:
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
    mapping(string => uint8) rostAntal;
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
