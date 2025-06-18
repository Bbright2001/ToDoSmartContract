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
    error taskDoesntExist(uint taskId);
    error notOwner(address caller, uint taskId);
    error noTaskName();
    error taskAlreadyCompleted(uint256 id);
    error invalidTaskId(uint256 id);
    error taskDeleted(uint256 taskId);
    
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
            isOwner: true;
        });

        userTasks[msg.sender].push(taskId);
        emit TaskAdded( _taskName, taskId);
    }
    
    function editTask(uint _taskId,string memory _newTaskName, priority _priority)external{
        Task storage task = tasks[_taskId]

        if(task.id != _taskId) revert taskDoesntExist(uint _taskId)
        //to confirm owner
        isOwner = false;
        uint[] storage ids = userTasks[ msg.sender];
        for(i = 0, i < ids.length, i++){
            if(ids[i] = _taskId){
                isOwner = true;
                break;
            }
        }

        if(!isOwner) revert notOwner(msg.sender, _taskId);

        if(task.deleted == true) revert taskDeleted(_taskId);

        task.id: _taskId;
        task.taskName: _newTaskName;
        task.completed: false;
        task.deleted: false;
        priority: _priority;

        emit modifyTask(_newTaskName, false)
           }
}