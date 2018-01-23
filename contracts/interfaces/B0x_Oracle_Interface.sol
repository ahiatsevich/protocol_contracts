/*
  Copyright 2018 b0x, LLC

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

pragma solidity ^0.4.9;

contract B0x_Oracle_Interface {

    // Address of the b0x vault contract.
    address public VAULT_CONTRACT;

    // Called by b0x automatically, but can be called outside b0x
    // Appropriate security logic (ex: ownerOnly) should be put in place if appropriate
    // loanOrderHash is provided and can be used to reference the order in b0x.
    // gasUsed can be provided for optional gas refunds.
    function orderIsTaken(
        address taker,
        bytes32 loanOrderHash,
        uint gasUsed)
        public;

    // Called by b0x automatically, but can be called outside b0x
    // Appropriate security logic (ex: ownerOnly) should be put in place if appropriate
    // loanOrderHash is provided and can be used to reference the order in b0x.
    // Details of the trade are provided.
    // usedGas can be provided for optional gas refunds.
    function tradeIsOpened(
        bytes32 loanOrderHash,
        address trader,
        address tradeTokenAddress,
        uint tradeTokenAmount,
        uint gasUsed)
        public;

    // Called by b0x to tell the oracle that interest has been sent to the oracle
    // Appropriate security logic (ex: ownerOnly) should be put in place if appropriate
    // loanOrderHash is provided and can be used to reference the order in b0x.
    // usedGas can be provided for optional gas refunds.
    function interestIsPaid(
        bytes32 loanOrderHash,
        address trader, // trader
        address interestTokenAddress,
        uint amount,
        uint gasUsed)
        public;





    // A trader calls this to close their own trade at any time
    function closeTrade(
        bytes32 loanOrderHash)
        public
        returns (bool);

    // Anyone can call this to liquidate the trade.
    // Logic should be added to check if the trade meets the requirments for liquidation.
    function liquidateTrade(
        bytes32 loanOrderHash,
        address trader)
        public
        returns (bool);



    // Should return a ratio of currentMarginAmount / liquidationMarginAmount
    function getMarginRatio(
        bytes32 loanOrderHash,
        address trader)
        public
        view
        returns (uint);

    // Returns True is the trade should be liquidated
    // Note: This can make use of the getMarginRatio() function, but it doesn't have to
    function shouldLiquidate(
        bytes32 loanOrderHash,
        address trader)
        public
        view
        returns (bool);

    function getRateData(
        address loanTokenAddress,
        address collateralTokenAddress,
        address tradeTokenAddress)
        public 
        view 
        returns (uint marginToLendRate, uint tradeToMarginRate);
}