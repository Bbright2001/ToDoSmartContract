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
    //Test to delete Tasks
    function testDeleteTask() external{
        vm.prank(user1);
        todo.taskAdd("leg day");
        todo.taskAdd("visit Aso rock");

        vm.prank(user1);
        todo.deleteTask(1, "visit Aso rock");
        (uint id,string memory name,,) = todo.tasks(1);
        assertEq(id, 0);
        assertEq(bytes(name).length, 0);
    }
    //Test to get all user task 
    function getMyTask() external{
        vm.prank(user1);
        todo.taskAdd("Learn Solidity");
        todo.taskAdd("Learn Cairo");
        todo.taskAdd("Learn rust");
        todo.taskAdd("fix a bug in Open source");
        vm.prank(user1);
        todo.editTask(0,"Build a Token");
        (,string memory _taskName,,) = todo.tasks(0);
        assertEq(_taskName, "Build a token");

        vm.prank(user1);
        ToDo.Task[] memory myTasks = todo.getAllTasks();

        assertEq(myTasks.length,4);
        assertEq(myTasks[0].taskName,"Build a Token");
    }
}