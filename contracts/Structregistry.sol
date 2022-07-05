pragma experimental ABIEncoderV2;
pragma solidity >=0.4.22 <0.8.0;

// Creating a Smart Contract
contract Structregistry {

  event Creation(
        address indexed from,
        string indexed vin
    );

     
    event Transfer(
        address indexed from,
        address indexed to,
        string indexed vin
    );


  struct users {

    address Account;
    string name;
    string gender;
    string Address;
    string phone;
    string password;
  }

  struct mechanic {

    address Account;
    string name;
    string gender;
    string Address;
    string phone;
    string garage;
  }

  struct car {

  address owner;
  string vin;
  string brand_name;
  string model_name;
  string purchase_date;
  string owner_name;
  string isFirstHandOwner;
  }

  struct Maintenance {
        string vin;
        string[] vehicleCondition;
        string[] currentOdometer;
        string[] currentEngineHours;
        string[] lastService;
        string[] ServiceType;
        string[]  partsReplaced;
        string[] cost;
        string[]  isUnderInsurance;
        string[] Message;

        uint256 count ;
        
    }

    struct Auther {  
           
            string id; //id is same as vin of a car
            address owner; 
            address[] auth_address; //array will contain all account address addedd by a particular car owner
    }

     struct OwnerList {  
           
            string vin; //id is same as vin of a car
           // address owner; 
             address[] carOwner_address; //array will contain all account address addedd by a particular car owner
    }

  users[] users_address;
  mechanic[] mech_address;
  car[] vehicle;
  address[] account_RegisterdMech;
  address[] account_RegisterdUser;
   address[] account_Registerd;
  string[] vin_array;
 

  mapping (string => Maintenance) maintenance;
  mapping (string => car) cars;
  mapping(string =>Auther) Auth_address; // id is mapped to Auther struct (key -> value pair)
  mapping(string =>OwnerList) ownerList;

address contract_owner =0x424f1CC8A9c3fe828e5159AB355546B114784488; //address of owner
 

function add_accountMech(address account) public{
  require(msg.sender == contract_owner);

  bool flag = false;
  for(uint256 i=0;i<account_RegisterdMech.length;i++)
    {
      if(account_RegisterdMech[i] == account){ 
      flag = true;
      break;
                                             }
    }
  require(flag==false);
  require(onlyRegisteredUser(account) == false);
  account_RegisterdMech.push(account);
  account_Registerd.push(account);

}

function add_accountUser(address account) public{
  require(msg.sender ==contract_owner);

  bool flag = false;
  for(uint256 i=0;i<account_RegisterdUser.length;i++)
    {
      if(account_RegisterdUser[i] == account){ 
      flag = true;
      break;
                                             }
    }
  require(flag==false);
   require(onlyRegisteredMech(account) == false);
  account_RegisterdUser.push(account);
  account_Registerd.push(account);

}

function onlyRegisteredMech(address account) internal returns (bool)  {
 
bool flag = false;
  for(uint256 i=0;i<account_RegisterdMech.length;i++)
    {
      if(account_RegisterdMech[i] == account){ 
      flag = true;
      break;
                                             }
    }
  return flag;
}

function onlyRegisteredUser(address account) internal returns (bool)  {
 
bool flag = false;
  for(uint256 i=0;i<account_RegisterdUser.length;i++)
    {
      if(account_RegisterdUser[i] == account){ 
      flag = true;
      break;
                                             }
    }
  return flag;
}

function onlyRegistered(address account) internal returns (bool)  {
 
bool flag = false;
  for(uint256 i=0;i<account_Registerd.length;i++)
    {
      if(account_Registerd[i] == account){ 
      flag = true;
      break;
                                             }
    }
  return flag;
}




function add_user(address Account, string memory name, string memory gender, string memory Address,
string memory phone, string memory password) public 
{
  // assert(msg.sender == ress);
  require(onlyRegisteredUser(Account) && msg.sender==Account);
  uint256 flag = 0;
  for(uint256 i=0;i<users_address.length;i++)
    {
      if(users_address[i].Account == Account){ 
      flag = 1;
      break;
                                             }
    }
  assert(flag!=1);
  users memory e = users(Account, name, gender, Address, phone, password);
  users_address.push(e);
}

function add_mech(address Account, string memory name, string memory gender, string memory Address, 
string memory phone, string memory garage) public 
{require(onlyRegisteredMech(Account) && msg.sender==Account);
  // assert(msg.sender == addressAdmin);
  uint256 flag = 0;
  for(uint256 i=0;i<mech_address.length;i++)
    {
      if(mech_address[i].Account == Account){ 
       flag = 1;
       break;
                                             }
    }
     
  assert(flag!=1);
  mechanic memory e = mechanic(Account, name, gender, Address, phone, garage);
  mech_address.push(e);
}
  
 
  
function addAuther(string  memory id ) internal 
{ 
  Auth_address[id].id = id;
  Auth_address[id].owner = msg.sender;
  Auth_address[id].auth_address.push(msg.sender);
}

function GrantViewPermission(string memory id , address add) public
{ //users can add authorized users who can view their maintenance report
  Auther storage transferObject = Auth_address[id];
  assert(transferObject.owner == msg.sender);
  transferObject.auth_address.push(add);
}

       
function viewAllowed(string memory id) public view returns (address[] memory) 
{//users can view users who can view their maintenance report
    Auther storage transferObject = Auth_address[id];
    assert(transferObject.owner == msg.sender);
    return transferObject.auth_address;
}

function viewAllOwner(string memory id) public returns (address[] memory) 
{//users can view users who can view their maintenance report
assert(onlyRegistered(msg.sender));
    OwnerList storage transferObject = ownerList[id];
   // assert(transferObject.owner == msg.sender);
    return transferObject.carOwner_address;
}


function RevokeViewPermission(string memory id , address account) public  
{//users can remove authorized users who can view their maintenance report
    
    Auther storage transferObject = Auth_address[id];
    assert(transferObject.owner == msg.sender);
    uint index = 0;
    bool flag = false;
    for(uint i=0;i<transferObject.auth_address.length;i++){
       if(transferObject.auth_address[i] == account )
       { 
           index = i;
           flag = true;
           break;
       }
    }
    assert(flag==true);
    address element_address = transferObject.auth_address[index];
    assert(element_address != Auth_address[id].owner );
    transferObject.auth_address[index] = transferObject.auth_address[transferObject.auth_address.length - 1];
    delete transferObject.auth_address[transferObject.auth_address.length - 1];
}

function getPassword(address Account) public view returns(string memory,string memory){
   
    uint i;
    for (i = 0; i < users_address.length; i++) {
        users memory e = users_address[i];
        if (e.Account == Account) {
         return (e.password,e.name);
                                  }
    }
    return ("Not Found","Not Found");
}

function viewUser(address Account) public returns(string memory, string memory,
    string memory, string memory, string memory) 
{
  require(onlyRegistered(msg.sender));
    uint i;
    for (i = 0; i < users_address.length; i++) {
        users memory e = users_address[i];
        if (e.Account == Account) {
         return (e.name, e.gender, e.Address, e.phone, e.password);
                                  }
    }
    return ("Not Found", "Not Found", "Not Found", "Not Found", "Not Found");
}

  
function viewMechanic(address Account) public returns(string memory, string memory,
    string memory, string memory, string memory) {
      require(onlyRegistered(msg.sender));
    uint i;
    for (i = 0; i < mech_address.length; i++) {
      mechanic memory e = mech_address[i];
      if (e.Account == Account) {
          return (e.name, e.gender, e.Address, e.phone, e.garage);
                                }
    }
    return ("Not Found", "Not Found", "Not Found", "Not Found", "Not Found");
}

  
function addCar(address owner , string memory vin,string memory brand_name, string memory model_name, string memory purchase_date, string memory owner_name, string memory isFirstHandOwner) public  {
    uint256 flag1 = 0;
  for(uint256 i=0;i<vin_array.length;i++){
    if (keccak256(abi.encodePacked(vin_array[i] )) == keccak256(abi.encodePacked(vin))) {
  // do something
    flag1 = 1;
        break;
}
     
  }
  assert(flag1==0);
  uint256 flag = 0;
  for(uint256 i=0;i<users_address.length;i++){
      if(users_address[i].Account == owner){ 
        flag = 1;
        break;
                                            }
  }
  assert(flag==1);
  assert(cars[vin].owner == 0x0000000000000000000000000000000000000000);// assert that owner value is not defined already
       
  cars[vin].vin = vin;
  cars[vin].owner = msg.sender;
	cars[vin].brand_name = brand_name;
	cars[vin].model_name = model_name;
	cars[vin].purchase_date = purchase_date;
  cars[vin].owner_name = owner_name;
  cars[vin].isFirstHandOwner = isFirstHandOwner;

    
  maintenance[vin].vin = vin;
   maintenance[vin].count = 1; 
   addAuther(vin); //so that car owner can view his maintenace report
   vin_array.push(vin);
   ownerList[vin].vin = vin;
   ownerList[vin].carOwner_address.push(owner);

 
   emit Creation(msg.sender, vin);//calling the event creation
   
}
 
 function getVin() public returns (string[] memory ){
   require(onlyRegistered(msg.sender));
   return vin_array;

 }

function getUsers() public  returns (address  []memory){
   require(onlyRegistered(msg.sender));
   return account_RegisterdUser;

 }
 function getMechanics() public returns (address []memory ){
   require(onlyRegistered(msg.sender));
   return account_RegisterdMech;

 }
uint256 num = 8;
//  function getReportCount(string memory vin) public returns (uint256 ){
  
//    //  assert(onlyAllowed(cars[vin].vin) == true);//if condition specified so that only authorized user/mechanic can view maintenance report

//      // Maintenance storage transferObject = maintenance[vin];
//      return num;

//  }
 

 
function viewCar(string memory vin) public  returns(address owner,  string memory  brand_name, 
string memory model_name,  string memory purchase_date , string memory owner_name , string memory isFirstHandOwner) {
        //only users added into system can view a car detail
require(onlyRegistered(msg.sender));
      car storage transferObject = cars[vin];
      //assert(transferObject.owner == msg.sender); 
      owner = cars[vin].owner;
      brand_name = cars[vin].brand_name;
      model_name = cars[vin]. model_name ;
      purchase_date = cars[vin].purchase_date;
      owner_name = cars[vin].owner_name;
      isFirstHandOwner = cars[vin].isFirstHandOwner;
}



 
function transferOwnership(string memory vin, address owner , string memory new_owner_name) public  
{ 
      //to tranfer ownership of a car to another user in the system

      car storage transferObject = cars[vin];
      assert(transferObject.owner == msg.sender); 
      transferObject.owner = owner;
      transferObject.owner_name = new_owner_name;//new owner name
      transferObject.isFirstHandOwner = "false"; //after the tranfer of ownership this variable value will become false

      Auther storage transferObject2 = Auth_address[vin];
      assert(transferObject2.owner == msg.sender);
      transferObject2.owner = owner;
      //delete transferObject2.auth_address;//............................................................................................
      transferObject2.auth_address[0] = owner;

       OwnerList storage transferObject3 = ownerList[vin];
       transferObject3.carOwner_address.push(owner);
      emit Transfer(msg.sender, owner, vin);//call event Transfer

} 

function updateMaintenanceReport(string  memory vin , string  memory  vehicleCondition, 
string memory  currentOdometer, string memory  currentEngineHours, string memory  lastService, 
string memory  ServiceType,string  memory  partsReplaced,string memory  cost,string  memory  isUnderInsurance, 
string memory  Message ) public onlyMechanic() {

  //to update maintenance report ...only accessible by mechanic who has been added into system by admin
       
 if(onlyAllowed(vin) == true){ //if condition specified so that only authorized mechanic can update maintenace report
   uint256 flag = 0;
   for(uint256 i=0;i<mech_address.length;i++){
      if(mech_address[i].Account == msg.sender){ 
        flag = 1;
        break;
                                                }
   }
     
   require(flag==1);
   Maintenance storage transferObject = maintenance[vin];
   transferObject.vin = vin;
   transferObject.vehicleCondition.push(vehicleCondition);
   transferObject.currentOdometer.push(currentOdometer);
   transferObject.currentEngineHours.push(currentEngineHours);
   transferObject.lastService.push(lastService);
   transferObject.ServiceType.push(ServiceType);
   transferObject.partsReplaced.push(partsReplaced);
   transferObject.cost.push(cost);
   transferObject.isUnderInsurance.push(isUnderInsurance);
   transferObject.Message.push(Message);
   transferObject.count =  transferObject.count + 1;

   }
    
}
    
function viewMaintenaceReport(string memory vin)  public returns( string memory vehicleCondition, 
string memory currentOdometer, string memory currentEngineHours, string memory lastService, 
string memory ServiceType,string memory  partsReplaced,string memory cost,string memory isUnderInsurance,
string memory Message , uint256 num)  {
    assert(onlyAllowed(cars[vin].vin) == true);//if condition specified so that only authorized user/mechanic can view maintenance report

      Maintenance storage transferObject = maintenance[vin];
      uint256 n = transferObject.currentOdometer.length-1;
      vehicleCondition = transferObject.vehicleCondition[n];
      currentOdometer = transferObject.currentOdometer[n];
      currentEngineHours = transferObject.currentEngineHours[n];
      lastService = transferObject.lastService[n];
      ServiceType = transferObject.ServiceType[n];
      partsReplaced = transferObject.partsReplaced[n];
      cost = transferObject.cost[n];
      isUnderInsurance = transferObject.isUnderInsurance[n];
      Message = transferObject.Message[n];
      num = n;
    
}

function viewMaintenaceReportByIndex(string memory vin, uint256 n)  public returns( string memory vehicleCondition, 
string memory currentOdometer, string memory currentEngineHours, string memory lastService, 
string memory ServiceType, string memory  partsReplaced,string memory cost,string memory isUnderInsurance,
string memory Message)  {
   // assert(onlyAllowed(cars[vin].vin) == true);//if condition specified so that only authorized user/mechanic can view maintenance report

      Maintenance storage transferObject = maintenance[vin];
     // uint256 n = transferObject.currentOdometer.length-1;
      vehicleCondition = transferObject.vehicleCondition[n];
      currentOdometer = transferObject.currentOdometer[n];
      currentEngineHours = transferObject.currentEngineHours[n];
      lastService = transferObject.lastService[n];
      ServiceType = transferObject.ServiceType[n];
      partsReplaced = transferObject.partsReplaced[n];
      cost = transferObject.cost[n];
      isUnderInsurance = transferObject.isUnderInsurance[n];
      Message = transferObject.Message[n];
    //  num = n;
    
}

modifier onlyMechanic(){ //modifier 
  uint flag = 0;
  for(uint256 j=0;j<mech_address.length;j++){
    if(mech_address[j].Account == msg.sender){
        flag = 1;
        break;
                                    }
  }
  require(flag == 1);
  _;
}

function onlyAllowed(string memory id) internal returns (bool){ //function to restrict access...used internal keyword
  uint flag = 0;
  for(uint256 j=0;j<Auth_address[id].auth_address.length;j++){
      //id is same as vin for car for a particular owner
      //auth_address is array which contain all users allowed by car owner to view mainteanace report
      if(Auth_address[id].auth_address[j] == msg.sender){
                flag = 1;
                break;
                                                        }
  }
  if(flag==1)
      return true;
  else
      return false;
}




//function onlyAllowed(string memory id) internal returns (bool){ //function to restrict access...used internal keyword
 
//}






 //function get_array() public view returns( car[] memory){
   //   return(vehicle);
  //}
}

