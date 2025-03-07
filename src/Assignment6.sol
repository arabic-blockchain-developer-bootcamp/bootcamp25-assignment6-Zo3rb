// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Assignment6 {
    // 1. Declare an event called `FundsDeposited` with parameters: `sender` and `amount`

    /**
    * @notice Event to be emitted once an address send a deposit transaction.
    * @param sender an address which will sends the transaction.
    * @param amount the amount of the transaction.
    */
    event FundsDeposited(address indexed sender, uint amount);


    // 2. Declare an event called `FundsWithdrawn` with parameters: `receiver` and `amount`

    /**
    * @notice Event to be emitted once an address send a withdrawn transaction.
    * @param receiver an address which will receives the transaction.
    * @param amount the amount of the transaction.
    */
    event FundsWithdrawn(address indexed receiver, uint amount);

    // 3. Create a public mapping called `balances` to tracker users balances

    /**
    * @notice Mapping to track the balances of users.
    */
    mapping(address => uint) public balances;

    // Modifier to check if sender has enough balance
    modifier hasEnoughBalance(uint amount) {
        // Fill in the logic using require
        require(balances[msg.sender] >= amount, "Insufficient balance");
        _;
    }

    // Function to deposit Ether
    // This function should:
    // - Be external and payable
    // - Emit the `FundsDeposited` event.

    /**
    * @notice Deposit an amount to the Sender Balance && Emit an Event.
    */
    function deposit() external payable {
        // increment user balance in balances mapping.
        balances[msg.sender] += msg.value;

        // emit suitable event
        emit FundsDeposited(msg.sender, msg.value);
    }

    // Function to withdraw Ether
    // This function should:
    // - Be external
    // - Take one parameter: `amount`
    // - Use the `hasEnoughBalance` modifier
    // - Emit the `FundsWithdrawn` event
    function withdraw(uint amount) external hasEnoughBalance(amount) {
        // decrement user balance from balances mapping
        balances[msg.sender] -= amount; 

        // send tokens to the caller
        payable(msg.sender).transfer(amount);

        // emit suitable event
        emit FundsWithdrawn(msg.sender, amount);
    }

    // Function to check the contract balance
    // This function should:
    // - Be public and view
    // - Return the contract's balance
    function getContractBalance() public view returns(uint) {
        // return the balance of the contract

        /**
        * ############# MSG to the Reviewer #############
        * I was Confused with this implementation.
        * Did it meant to return the Contract Balance from the
        * Balances Mapping or The Contract's Ether Balance.
        * I Searched The Internet and Found that I can return
        * The I can Retrieve the Contract's Balance of Ether
        * Using the Statement of the Function Return's Statement in this Task.
        * Otherwise I was going to return the Comment Below:
        * return balances[address(this)];
        */
        return address(this).balance;
    }
}
