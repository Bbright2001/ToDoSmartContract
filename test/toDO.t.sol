// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ToDo} from "../src/toDO.sol";

contract tesToDo is Test {
    ToDo public todo;
    address public user1;

    function setUp() public{
        todo = new ToDo();
        user1 = address(0x1);
    } 

    //Test to add tasks
    function testAddTask() external {

        vm.prank(user1);
        todo.taskAdd("buy grocery");
        (uint id,,bool completed,) = todo.tasks(0);
        assertEq(id, 0);
        assertEq(completed, false);
    }
    // Test to edit tasks

    function testEditTask() external{
        vm.prank(user1);
        todo.taskAdd("participate in Grass Airdrop");
        vm.prank(user1);
        todo.editTask(0, "Learn Rust and Solidity");
        (,string memory _newName,bool completed,) = todo.tasks(0);
        assertEq(_newName, "Learn Rust and Solidity");
        assertEq(completed, false);
    }
}