pragma solidity ^0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'WCRole' to manage this role - add, remove, check
contract WCRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event WCAdded(address indexed account);
  event WCRemoved(address indexed account);

  // Define a struct 'wcs' by inheriting from 'Roles' library, struct Role
  Roles.Role private wcs;

  // In the constructor make the address that deploys this contract the 1st WC
  constructor() public {
    _addWC(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyWC() {
    require(isWC(msg.sender));
    _;
  }

  // Define a function 'isWC' to check this role
  function isWC(address account) public view returns (bool) {
    return wcs.has(account);
  }

  // Define a function 'addWC' that adds this role
  function addWC(address account) public onlyWC {
    _addWC(account);
  }

  // Define a function 'renounceWC' to renounce this role
  function renounceWC() public {
    _removeWC(msg.sender);
  }

  // Define an internal function '_addWC' to add this role, called by 'addWC'
  function _addWC(address account) internal {
    wcs.add(account);
    emit WCAdded(account);
  }

  // Define an internal function '_removeWC' to remove this role, called by 'removeWC'
  function _removeWC(address account) internal {
    wcs.remove(account);
    emit WCRemoved(account);
  }
}