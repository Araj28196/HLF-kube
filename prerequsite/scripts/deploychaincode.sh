CHANNEL_NAME="mychannel"
CHAINCODE_NAME="wholesaleclaim"
CC_RUNTIME_LANGUAGE="golang"
VERSION="1.0"
SEQUENCE="1"
PACKAGE_ID_ORG1="9683d43531281d83b7f3a1fd6c7afcb35ce20975ba9bfc4efbbd8e8928ff8602"
PACKAGE_ID_ORG2="2c9ee2c2bc9adc7ff61cd85baa37f843879a0d8bbd0f06dbc6e0eb3f1c9a4aaa"

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

commitchaincode(){
peer lifecycle chaincode commit -o orderer:7050 --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $VERSION --sequence $SEQUENCE --init-required --tls true --cafile $ORDERER_CA --peerAddresses peer0-org1:7051 --tlsRootCertFiles /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0-org2:7051 --tlsRootCertFiles /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt --waitForEvent
}

commitchaincode_org1(){
peer lifecycle chaincode commit -o orderer:7050 --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $VERSION --sequence $SEQUENCE --init-required --tls true --cafile $ORDERER_CA --peerAddresses peer0-org1:7051 --tlsRootCertFiles /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
}

commitchaincode_org2(){
peer lifecycle chaincode commit -o orderer:7050 --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $VERSION --sequence $SEQUENCE --init-required --tls true --cafile $ORDERER_CA --peerAddresses peer0-org2:7051 --tlsRootCertFiles /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
}

InitLedger(){
peer chaincode invoke -o orderer:7050 --isInit --tls true --cafile $ORDERER_CA -C $CHANNEL_NAME -n $CHAINCODE_NAME --peerAddresses peer0-org1:7051 --tlsRootCertFiles /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0-org2:7051 --tlsRootCertFiles /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"Args":["InitLedger"]}' --waitForEvent
}

Invoke_chaincode(){
peer chaincode invoke -o orderer:7050 --tls true --cafile $ORDERER_CA -C $CHANNEL_NAME -n $CHAINCODE_NAME --peerAddresses peer0-org1:7051 --tlsRootCertFiles /organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0-org2:7051 --tlsRootCertFiles /organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"Args":["CreateAsset","asset100","red","50","tom","300"]}' --waitForEvent
}

Query_chaincode(){
peer chaincode query -C $CHANNEL_NAME -n $CHAINCODE_NAME -c '{"Args":["GetAllAssets"]}'
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
