Vehicular Data Management and Trading Using Blockchain Technology		    
Project  (PROJ-CS881)
            Under the guidance of
			   Dr. Bikromadittya Mondal
Submitted by
Name:	Ritesh Raman		Name: Pratyush
Roll No.:	11500118066		Roll No.:  11500118079
Regn. No.:	181150110083      Regn. No.: 181150110070
		
Name:	Vivek Verma		     Name: Shubhang Sharma
Roll No.:	11500118024	     Roll No.: 11500118047
Regn. No.:	181150110125     Regn. No.: 181150110102



prerequisite:
1.install visual studio code
2.Node.js
3.ganache -- download from here https://www.trufflesuite.com/ganache
4.Web3.js -- for download run this in terminal > npm install web3
5.truffle -- for download run this in terminal > npm install truffle -g
6.install metamask extension in your browser.

Steps to run this project:-
1.Extract the zip in your local system.
2.Import the project in VS code.
3.open ganache and select quickstart ethereum.
4.using netwok tab in metamask add a network into it(our system will run in this network)
 >network name : localHost
 >New RPC URL:COPY RPC SERVER URL FROM GANACHE AND PASTE IT HERE
 >Chain id:1337
 >Currenecy symbol : ETH
5.Copy the the first address from the ganache account and paste it as the value of contract_owner in Structregistry.sol file.
(truffle always use first account of ganache to deploy the smart contract)
6.import accounts from ganache using their private key into metamask(the first account is mandatory to import as it will be owner of our system/smart contract)
7.run truffle migrate in terminal where your truffle-config.js file is present
8.the smart contract is automatically created only need to fill the data
9.Run the dashboard.html
10. Congratulations... You are all set.
11.always start from step 3 when you close the project and want to re-run it as ganache is for testing dapp application.


Small demo into the System>
>use metamask to select different account for transaction purpose.
>before adding a mechanic or user to the system,it is mandatory to add their ethereum address into the system by the owner first(from owner ethereum account )
>a mechanic can not register as a user and vice versa.
>most of the basic operation like viewing car data can only done by those accounts which are addded into the system by owner.
>mechanic can not register a car.
>only authorized user can view maintainance report(previous ones also) and authorized mechanic can update/see the report.car owner can
 also revoke the above mentioned  permission if they want.
>no need of admin to transfer car ownership
>can see car previous owner's account 


