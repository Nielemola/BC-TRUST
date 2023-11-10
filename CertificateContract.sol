// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract CertificateContract {

    mapping (address => NodeStruct) public nodes;   // Setting up the index
    address[] public nodeAccounts;                  // Initialisation address
    OwnerStruct public owner;                       // Initialisation struct
    uint public indexNode;                          // Initialisation index Node
    address private from = msg.sender;              // Set the call address to the address of the published contract

    constructor (string memory ProofLinks) public {
        owner.ownerAddress = msg.sender;
        owner.proofLinks = ProofLinks;
        owner.timestamps = block.timestamp;
        indexNode = 0;
    }

    struct OwnerStruct {
        address ownerAddress;
        string proofLinks;
        uint timestamps;
    }

    struct NodeStruct {
        string nodeNotes;
        uint nodeSince;
        uint nodeIndex;
    }

    modifier onlyOwner {                        // Modifier settings can only be called by the owner
        require(from == msg.sender,"not owner");
        _;
    }

    modifier onlyNodes {                        // Modifier settings can only be called by the PN
        for(uint i=0;i <= nodeAccounts.length-1;i++ ){
            if (nodeAccounts[i] == msg.sender){
                require(nodeAccounts[i] == msg.sender,"not owner");     
                _;
            }
        }
    }

    function addNode(address _nodeAddress, string memory _nodeNotes) public onlyOwner {         //add noed
        require(nodes[_nodeAddress].nodeSince == 0, "Node already exists");
        nodes[_nodeAddress] = NodeStruct({nodeNotes: _nodeNotes,nodeSince: block.timestamp,nodeIndex: indexNode});
        nodeAccounts.push(_nodeAddress);
        indexNode++;
    }

    function removeNode(address _nodeAddress) public onlyNodes {                                //remove node
        if(from == msg.sender){
            require(nodes[_nodeAddress].nodeSince != 0, "Node does not exist");
        }
        else{
            require(_nodeAddress == msg.sender);
            require(nodes[_nodeAddress].nodeSince != 0, "Node does not exist");
        }
        delete nodeAccounts[nodes[_nodeAddress].nodeIndex];                                     //delete address from nodeAccounts
        nodeAccounts[nodes[_nodeAddress].nodeIndex] = nodeAccounts[nodeAccounts.length - 1];    //copy last item to the just deleted address
        NodeStruct storage node = nodes[nodeAccounts[nodes[_nodeAddress].nodeIndex]];           //
        node.nodeIndex = nodes[_nodeAddress].nodeIndex;                                         //update the nodeIndex of the corresponding Node struct of moved item
        nodeAccounts.pop();                                                                     //remove the last item (same as the moved one)
        delete nodes[_nodeAddress];                                                             //delete node from mapping
        indexNode--;
           
    }
    function getNodes() public view returns (address[] memory){                                 // get node infomation
        return nodeAccounts;
    }

    mapping(address=>uint) public eval;
    event Log(address indexed sender,uint indexed val);
    function evaluation(uint8 x) external {                                                     //evaluation
        require(x<6&&x>0);
        emit Log(msg.sender,x);
        eval[msg.sender] = x;
    }
}