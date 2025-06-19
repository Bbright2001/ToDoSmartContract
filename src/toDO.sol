// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract ToDo{

    //State
    struct Task {
        uint256 id;
        string taskName;
        bool completed;
        bool deleted;
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
    event TaskDeleted(string taskName, uint256 _taskId);
    //constructor
        constructor() {
            owner = msg.sender;
        }

    //functions
    function taskAdd(string memory _taskName) external {
        uint taskId = nextTaskId++;

        tasks[taskId] = Task({
            id: taskId,
            taskName: _taskName,
            completed: false,
            deleted: false
        });

        userTasks[msg.sender].push(taskId);
        emit TaskAdded( _taskName, taskId);
    }
    
    function editTask(uint _taskId,string memory _newTaskName)external{
        Task storage task = tasks[_taskId];

        if(task.id != _taskId) revert taskDoesntExist( _taskId);
        //to confirm owner
        bool isOwner = false;
        uint[] storage ids = userTasks[ msg.sender];
        for(uint i = 0; i < ids.length; i++){
            if(ids[i] == _taskId){
                isOwner = true;
                break;
            }
        }

        if(!isOwner) revert notOwner(msg.sender, _taskId);

        if(task.deleted == true) revert taskDeleted(_taskId);

        task.id = _taskId;
        task.taskName = _newTaskName;
        task.completed =  false;
        task.deleted = false;

        emit modifyTask(_newTaskName, false);
           }
    function deleteTask(uint _taskId, string memory _taskName) external {
        Task storage task = tasks[_taskId];
        if(task.deleted == true) revert taskDeleted(_taskId);
        require(task.completed == true, "This tasks has not been completed");
        if(!(task.id == _taskId))  revert taskDoesntExist(_taskId);

        bool found = false;
        uint[] storage ids = userTasks[msg.sender];
        for(uint i = 0; i < ids.length; i++){
            if(ids[i] == _taskId){
                found = true;

                ids[i] = ids[ids.length -1];
                ids.pop();
                break;
            }
        }
          delete task.id;


          emit TaskDeleted(_taskName, _taskId);
    }
    function getAllTasks() external view returns( Task[] memory){
       uint[] memory ids = userTasks[msg.sender];
       Task[] memory myTask = new Task[](ids.length);

       for( uint i = 0; i < ids.length; i++){
        myTask[i] = tasks[ids[i]];
       }
        return myTask;
    }
}