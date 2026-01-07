// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.31;

contract filmFavoriter {
  
  struct Omrostning {
    string title;
    address skapare;
    uint8 slutTid;
    status nuvarandeStatus;
    string[] filmAlternativ;
    mapping(string => uint8) rostAntal;
    mapping(address => bool) harRostat;
  }
}