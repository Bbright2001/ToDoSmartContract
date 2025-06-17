// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract ToDo{

   enum priority {low, medium, high} 
    //State
    struct Task {
        uint256 id;
        string taskName;
        bool completed;
        bool deleted;
    }

        address public owner;
    mapping(address => Task[]) public userTasks;
    //error
    error taskNOtFound(uint256 id);
    error notOwner(address caller);
    error noTaskName();
    error taskAlreadyCompleted(uint256 id);
    error taskAlreadyExist(uint256 id);
    
    //events
    event completedTask(string taskName, bool completed);
    event addTask(string taskName, bool completed);
    event modifyTask(string NewTaskName, bool completed);
    event deleteTask(string taskName, bool deleted);
    //constructor
        constructor() {
            owner = msg.sender;
        }
    //modifiers
     modifier onlyOwner(address _caller) {
        if(owner == msg.sender) revert notOwner(_caller);
        _;
     }

     modifier taskNotDone(uint _taskId){
            Task storage task = userTasks[msg.sender][_taskId];
            if(task.completed) revert taskAlreadyCompleted(_taskId);
            _;
     }
    //functions
    
}