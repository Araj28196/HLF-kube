CHANNEL_NAME="mychannel"
CHAINCODE_NAME="basic"
CC_RUNTIME_LANGUAGE="golang"
VERSION="1.0"
SEQUENCE="1"
PACKAGE_ID_ORG1="7010dc6f08c0f792bd73680ab0be7ebabd6750e9f94bdee0b79066317ef8ea48"
PACKAGE_ID_ORG2="d06cfa42523ecb225ff9e539729064d6a21c507020cdfacf21fbbe209564d099"

#Approve chaincode

approveChaincode_peer0_org1() {
  peer lifecycle chaincode approveformyorg --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $VERSION --init-required --package-id $CHAINCODE_NAME:$PACKAGE_ID_ORG1 --sequence $SEQUENCE -o orderer:7050 --tls --cafile $ORDERER_CA
}

approveChaincode_peer0_org2() {
  peer lifecycle chaincode approveformyorg --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $VERSION --init-required --package-id $CHAINCODE_NAME:$PACKAGE_ID_ORG2 --sequence $SEQUENCE -o orderer:7050 --tls --cafile $ORDERER_CA
}

checkcommitreadiness(){
peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $VERSION --init-required --sequence $SEQUENCE -o orderer:7050 --tls --cafile $ORDERER_CA
}

commitchaincode_org1(){
peer lifecycle chaincode commit -o orderer:7050 --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $VERSION --sequence $SEQUENCE --init-required --tls true --cafile $ORDERER_CA --peerAddresses peer0-org1:7051 --tlsRootCertFiles /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
}

commitchaincode_org2(){
peer lifecycle chaincode commit -o orderer:7050 --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $VERSION --sequence $SEQUENCE --init-required --tls true --cafile $ORDERER_CA --peerAddresses peer0-org2:7051 --tlsRootCertFiles /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
}

InitLedger(){
peer chaincode invoke -o orderer:7050 --isInit --tls true --cafile $ORDERER_CA -C mychannel -n basic --peerAddresses peer0-org1:7051 --tlsRootCertFiles /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0-org2:7051 --tlsRootCertFiles /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"Args":["InitLedger"]}' --waitForEvent
}

Invoke_chaincode(){
peer chaincode invoke -o orderer:7050 --tls true --cafile $ORDERER_CA -C mychannel -n basic --peerAddresses peer0-org1:7051 --tlsRootCertFiles /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0-org2:7051 --tlsRootCertFiles /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"Args":["CreateAsset","asset100","red","50","tom","300"]}' --waitForEvent
}

Query_chaincode(){
    peer chaincode query -C mychannel -n basic -c '{"Args":["GetAllAssets"]}'
}

# Call the functions

#approveChaincode_peer0_org1
#approveChaincode_peer0_org2
#checkcommitreadiness
#commitchaincode_org1 #notworking
#commitchaincode_org2 #notworking
#InitLedger
#Invoke_chaincode
#Query_chaincode
