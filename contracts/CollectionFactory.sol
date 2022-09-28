// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/Clones.sol";

contract CollectionFactory {
  address public implement;

  mapping(address => address[]) collectionByOwner;

  event CreateCollection(address indexed creator, address collection);

  constructor(address _implement) {
    implement = _implement;
  }

  function createNewCollection(
    string memory _name,
    string memory _symbol,
    string memory _baseURI
  ) public {
    address newCollectionAddress = Clones.clone(implement);
    collectionByOwner[msg.sender].push(newCollectionAddress);
    ICollection(newCollectionAddress).initialize(_name, _symbol, _baseURI);
    emit CreateCollection(msg.sender, newCollectionAddress);
  }

  function getCollectionsByOwner(address owner) public view returns(address[] memory){
    return collectionByOwner[owner];
  }
}

interface ICollection{
  function initialize(string memory _name, string memory _symbol, string memory _bURI) external;
}
