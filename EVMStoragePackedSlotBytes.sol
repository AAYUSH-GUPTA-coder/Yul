// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract EVMStoratePackedSlotBytes {
    // slot 0 (packed right to left)
    // slot 0 is empty. 0x000000.........0000
    bytes4 public b4 = 0xabababab;
    // slot 0: 0x000.....abababab
    bytes2 public b2 = 0xcdcd;

    // slot 0: 0x0000.........cdcdabababab
    // slot 0: b4 + b2 and remember data is store on right to left

    function get() public view returns (bytes32 b32) {
        assembly {
            b32 := sload(0)
        }
    }
}

contract BitMasking {
    //      256 bits               |
    // 000 ... 001 | 000 ... 000
    // 000 ... 000 | 111 ... 111
    function test_mask() public pure returns (bytes32 mask) {
        assembly {
            // mask := shl(16,1)
            // 0x0000000000000000000000000000000000000000000000000000000000010000
            mask := sub(shl(16, 1), 1)
            // 0x000000000000000000000000000000000000000000000000000000000000ffff
        }
    }

    function test_shift_mask() public pure returns (bytes32 mask) {
        assembly {
            // 000....000 | 111 ... 111 | 000 ... 000
            //            | 16 bits     | 32 bits
            mask := shl(32, sub(shl(16, 1), 1))
            // 0x0000000000000000000000000000000000000000000000000000ffff_00_00_00_00
        }
    }

    // 111 ... 111 | 000 ... 000 | 111 ... 111
    //             | 16 bits     | 32 bits
    function test_not_mask() public pure returns (bytes32 mask) {
        assembly {
            // mask := shl(32, sub(shl(16,1),1))
            // 0x0000000000000000000000000000000000000000000000000000ffff00000000
            mask := not(shl(32, sub(shl(16, 1), 1)))
            // 0xffffffffffffffffffffffffffffffffffffffffffffffffffff0000ffffffff
        }
    }
}
