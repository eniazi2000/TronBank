//SPDX-License-Identifier: MIT 
pragma solidity 0.8.7;
import "./SafeMath.sol";
contract TronBanking{
    using SafeMath for uint256;
    mapping(address => uint) public balances;
    address owner;
    constructor(){
        owner = msg.sender;
    }
    event Received(address, uint);
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
    function deposite() public payable{
        balances[owner] += msg.value.div(100).mul(2);
        balances[msg.sender] += msg.value.div(100).mul(98); 
    }
    function withdraw(uint _amount) public{
        require(balances[msg.sender]>= _amount, "Not enough tron");
        balances[msg.sender] -= _amount;
        (bool sent,) = msg.sender.call{value: _amount}("Sent");
        require(sent, "failed to send tron");
    }
    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }
    function getOwner() public view returns(address)
    {
        return owner;
    }
    function getBalance(address author) public view returns(uint256)
    {
        return balances[author];
    }
}