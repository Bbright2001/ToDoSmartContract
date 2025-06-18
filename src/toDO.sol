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
    mapping(address => Task[]) public userTasks;
    //error
    error taskNOtFound(uint256 id);
    error notOwner(address caller);
    error noTaskName();
    error taskAlreadyCompleted(uint256 id);
    error invalidTaskId(uint256 id);
    
    //events
    event completedTask(string taskName, bool completed);
    event addTask(string taskName, uint256 id);
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
    function taskAdd(string memory _taskName, uint _taskId, Priority _priority) external {
    
        if(_taskId != userTasks[msg.sender].length) revert invalidTaskId(_taskId);

            userTasks[msg.sender].push(Task({
                id : _taskId,
                taskName: _taskName,
                completed: false,
                deleted: false,
                priority: _priority
            }));
            emit addTask(_taskName, _taskId);
    }
    
    
}