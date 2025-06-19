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
    
}