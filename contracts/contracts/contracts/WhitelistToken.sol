// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WhitelistToken is ERC20, Ownable {
    mapping(address => bool) private _whitelist;

    event AddressWhitelisted(address indexed account);
    event AddressRemoved(address indexed account);

    constructor(string memory name_, string memory symbol_, uint256 supply)
        ERC20(name_, symbol_)
    {
        _mint(msg.sender, supply);
        _whitelist[msg.sender] = true;
    }

    function whitelistAddress(address account) external onlyOwner {
        _whitelist[account] = true;
        emit AddressWhitelisted(account);
    }

    function removeWhitelistAddress(address account) external onlyOwner {
        _whitelist[account] = false;
        emit AddressRemoved(account);
    }

    function isWhitelisted(address account) public view returns (bool) {
        return _whitelist[account];
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20)
    {
        super._beforeTokenTransfer(from, to, amount);
        if (from != address(0) && to != address(0)) {
            require(
                _whitelist[from] && _whitelist[to],
                "WhitelistToken: not whitelisted"
            );
        }
    }
}