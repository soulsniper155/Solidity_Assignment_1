pragma solidity ^0.8.0;

contract EnrollStudent{
    address private contract_address = payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    enum Gender{    male,   female,     other   }
    enum Appearance{    online,     onsite}
    
    struct Student{ // Define user define dataType to track the Student
        string name;
        string l_name;
        address Address;
        uint ammount;   
        Gender gender;
        Appearance appearance;
        bool is_having_degree;
    }
    
    mapping(uint => Student ) access_studemt; // Map the Student Record
    uint public numEnrollStudents;  // For Tracking how many students are enrolled
    event TrasferAmount(address, uint);//contract_address , TrasferAmount from EOA
    event TransactonFailed(string);
    
    
    // Funtion Will Get the new user data and Make a Transation To Contact Account
    function newStudent(string memory FirstName,string memory Last_Name,bool having_degree,Gender gender,Appearance appearance) public verifyOwner payable {
        
        address payable transferTo = payable(contract_address);
        if(msg.value == 2 ether){
                transferTo.transfer(msg.value);
                uint std_id = numEnrollStudents++;
                access_studemt[std_id] = Student(FirstName,Last_Name,msg.sender,msg.value,gender,appearance,having_degree);
                emit TrasferAmount(contract_address,msg.value);
        }
        else{
                emit TransactonFailed("Unable to Process Transaction Due to Unexpected ether transfer");
                revert();   
        }
    }
    //This modifier will run Before executing the new function 
    modifier verifyOwner(){
        
        if( msg.sender != contract_address && msg.value >=2 ether){
            _;
        }
    }
    
    //Set the contract_address using this function
    function setAddress(address payable add) public {
            contract_address = add;
    }
    
    // Get contract balance
    function getBalance() public view returns(uint){
            return contract_address.balance;
    }
    
    // Get the Contract Address
    function getAddress() public view returns(address){
            return contract_address;
    }
  
}

