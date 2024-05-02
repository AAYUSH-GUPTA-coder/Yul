// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Yul - language used for Solidity inline assembly
contract YulIntro {
     // Yul assignment
    function test_yul_var() public pure returns(uint256){
        uint256 s = 0;

        assembly {
            // Declare variable
            let x := 1
            // Reassign
            x := 2
            // Assign to Solidity variable
            s := 2
        }
        return s;
    }

    // Yul types (everything is bytes32)
    function test_yul_types() public pure returns(bool x, uint256 y, bytes32 z){
        assembly{
            x := 1
            y := 0x1
            z := "Hello YUL"
        }
    }
}

    contract EVMStorageSingleSlot {
        // EVM Storage
        // 2**256 slotes, each slots can store upto 32 bytes
        // Slots are assigned in the order the state variables are decleared
        // Data < 32 bytes are packed into a slot (right to left)
        // sstore(k,v) = store v to slot k
        // sload(k) = load 32bytes from slot K

        // Example: Single variable stored in one slot

        // slot 0
        uint256 public s_x;

        // slot 1
        uint256 public s_y;

        // slot 2
        bytes32 public s_z;

        // example : sstore(k,v)
        function test_sstore() public {
            assembly{
                sstore(0, 100)
                sstore(1, 111)
                sstore(2, 0xabab)
            }
        }

        // example : sstore(k,v), instead of manually calculatng the slot number. use 
        // variableName.slot. i.e s_x.slot
        function test_sstore_better() public {
            assembly{
                sstore(s_x.slot, 2100)
                sstore(s_y.slot, 2111)
                sstore(s_z.slot, 0xccabab)
            }
        }

        // example: sload(k) = load 32bytes from slot K
        function test_sload() public view returns(uint256 x, uint256 y, bytes32 z){
            assembly{
                x := sload(0)
                y := sload(1)
                z := sload(2)
            }
        }

        // example : sload(k) , instead of manually calculatng the slot number. use 
        // variableName.slot. i.e s_x.slot
        function test_sload_better() public view returns(uint256 x, uint256 y, bytes32 z){
            assembly{
                x := sload(s_x.slot)
                y := sload(s_y.slot)
                z := sload(s_z.slot)
            }
        }
    }