// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract ToDo{

   enum Priority {low, medium, high} 
    //State
    struct Task {
        uint256 id;
        string taskName;
        bool completed;
        bool deleted;
        Priority priority;
    }

        address public owner;
        uint nextTaskId;
    mapping(uint => Task) public tasks;
    mapping(address => uint[]) public userTasks;
    //error
    error taskNOtFound(uint256 id);
    error notOwner(address caller);
    error noTaskName();
    error taskAlreadyCompleted(uint256 id);
    error invalidTaskId(uint256 id);
    
    //events
    event completedTask(string taskName, bool completed);
    event TaskAdded(string taskName, uint256 id);
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


    //functions
    function taskAdd(string memory _taskName, Priority _priority) external {
        uint taskId = nextTaskId++;

        tasks[taskId] = Task({
            id: taskId,
            taskName: _taskName,
            completed: false,
            deleted: false,
            priority: _priority
        });

        userTasks[msg.sender].push(taskId);
        emit TaskAdded( _taskName, taskId);
    }
    
    
}