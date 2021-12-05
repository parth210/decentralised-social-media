pragma solidity >=0.7.0 <0.9.0;

contract Mapper {

    event AddressMapped(address primary, address secondary);
    event Error(uint code, address sender);

    mapping (address => address) public primaryToSecondary;
    mapping (address => bool) public secondaryInUse;

    modifier secondaryAddressMustBeUnique(address secondary) {
        if(secondaryInUse[secondary]) {
            emit Error(1, msg.sender);
            revert();
        }
        _;
    }

    function mapAddress(address secondary)
        secondaryAddressMustBeUnique(secondary) public{
        // If there is no mapping, this does nothing
        secondaryInUse[primaryToSecondary[msg.sender]] = false;

        primaryToSecondary[msg.sender] = secondary;
        secondaryInUse[secondary] = true;

        emit AddressMapped(msg.sender, secondary);
    }
}
