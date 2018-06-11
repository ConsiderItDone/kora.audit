//OK
pragma solidity ^0.4.23;


/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/179
 */
//OK
contract ERC20Basic {
    //OK
    function totalSupply() public view returns (uint256);
    //OK
    function balanceOf(address who) public view returns (uint256);
    //OK
    function transfer(address to, uint256 value) public returns (bool);
    //OK
    event Transfer(address indexed from, address indexed to, uint256 value);
}


/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
//OK
contract ERC20 is ERC20Basic {
    //OK
    function allowance(address owner, address spender)
        //OK
    public view returns (uint256);

    //OK
    function transferFrom(address from, address to, uint256 value)
        //OK
    public returns (bool);

    //OK
    function approve(address spender, uint256 value) public returns (bool);
    //OK
    event Approval(
    //OK
        address indexed owner,
    //OK
        address indexed spender,
    //OK
        uint256 value
    );
}


/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
//OK
library SafeMath {

    /**
    * @dev Multiplies two numbers, throws on overflow.
    */
    //OK
    function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
        //OK
        if (a == 0) {
            //OK
            return 0;
            //OK
        }
        //OK
        c = a * b;
        //OK
        assert(c / a == b);
        //OK
        return c;
    }

    /**
    * @dev Integer division of two numbers, truncating the quotient.
    */
    //OK
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        // uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        //OK
        return a / b;
    }

    /**
    * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
    */
    //OK
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        //OK
        assert(b <= a);
        //OK
        return a - b;
    }

    /**
    * @dev Adds two numbers, throws on overflow.
    */
    //OK
    function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
        //OK
        c = a + b;
        //OK
        assert(c >= a);
        //OK
        return c;
    }
}


/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
//WARNING: implemented, but not used
contract Ownable {
    //OK
    address public owner;


    //OK
    event OwnershipRenounced(address indexed previousOwner);
    //OK
    event OwnershipTransferred(
    //OK
        address indexed previousOwner,
    //OK
        address indexed newOwner
    );


    /**
     * @dev The Ownable constructor sets the original `owner` of the contract to the sender
     * account.
     */
    //OK
    constructor() public {
        //OK
        owner = msg.sender;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    //OK
    modifier onlyOwner() {
        //OK
        require(msg.sender == owner);
        //OK
        _;
    }

    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    //OK
    function transferOwnership(address newOwner) public onlyOwner {
        //OK
        require(newOwner != address(0));
        //OK
        emit OwnershipTransferred(owner, newOwner);
        //OK
        owner = newOwner;
    }

    /**
     * @dev Allows the current owner to relinquish control of the contract.
     */
    //WARNING: can cause lose control over the contract
    function renounceOwnership() public onlyOwner {
        //OK
        emit OwnershipRenounced(owner);
        //OK
        owner = address(0);
    }
}




/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 */
//OK
contract BasicToken is ERC20Basic {
    //OK
    using SafeMath for uint256;

    //OK
    mapping(address => uint256) balances;

    //OK
    uint256 totalSupply_;

    /**
    * @dev total number of tokens in existence
    */
    //OK
    function totalSupply() public view returns (uint256) {
        //OK
        return totalSupply_;
    }

    /**
    * @dev transfer token for a specified address
    * @param _to The address to transfer to.
    * @param _value The amount to be transferred.
    */
    //OK
    function transfer(address _to, uint256 _value) public returns (bool) {
        //OK
        require(_to != address(0));
        //OK
        require(_value <= balances[msg.sender]);

        //OK
        balances[msg.sender] = balances[msg.sender].sub(_value);
        //OK
        balances[_to] = balances[_to].add(_value);
        //OK
        emit Transfer(msg.sender, _to, _value);
        //OK
        return true;
    }

    /**
    * @dev Gets the balance of the specified address.
    * @param _owner The address to query the the balance of.
    * @return An uint256 representing the amount owned by the passed address.
    */
    //OK
    function balanceOf(address _owner) public view returns (uint256) {
        //OK
        return balances[_owner];
    }

}


/**
 * @title Standard ERC20 token
 *
 * @dev Implementation of the basic standard token.
 * @dev https://github.com/ethereum/EIPs/issues/20
 * @dev Based on code by FirstBlood: https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 */
//OK
contract StandardToken is ERC20, BasicToken {

    //OK
    mapping (address => mapping (address => uint256)) internal allowed;


    /**
     * @dev Transfer tokens from one address to another
     * @param _from address The address which you want to send tokens from
     * @param _to address The address which you want to transfer to
     * @param _value uint256 the amount of tokens to be transferred
     */
    //OK
    function transferFrom(
    //OK
        address _from,
    //OK
        address _to,
    //OK
        uint256 _value
    )
        //OK
    public
        //OK
    returns (bool)
    {
        //OK
        require(_to != address(0));
        //OK
        require(_value <= balances[_from]);
        //OK
        require(_value <= allowed[_from][msg.sender]);

        //OK
        balances[_from] = balances[_from].sub(_value);
        //OK
        balances[_to] = balances[_to].add(_value);
        //OK
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        //OK
        emit Transfer(_from, _to, _value);
        //OK
        return true;
    }

    /**
     * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
     *
     * Beware that changing an allowance with this method brings the risk that someone may use both the old
     * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
     * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     * @param _spender The address which will spend the funds.
     * @param _value The amount of tokens to be spent.
     */
    //OK
    function approve(address _spender, uint256 _value) public returns (bool) {
        //OK
        allowed[msg.sender][_spender] = _value;
        //OK
        emit Approval(msg.sender, _spender, _value);
        //OK
        return true;
    }

    /**
     * @dev Function to check the amount of tokens that an owner allowed to a spender.
     * @param _owner address The address which owns the funds.
     * @param _spender address The address which will spend the funds.
     * @return A uint256 specifying the amount of tokens still available for the spender.
     */
    function allowance(
    //OK
        address _owner,
    //OK
        address _spender
    )
        //OK
    public
        //OK
    view
        //OK
    returns (uint256)
    {
        //OK
        return allowed[_owner][_spender];
    }

    /**
     * @dev Increase the amount of tokens that an owner allowed to a spender.
     *
     * approve should be called when allowed[_spender] == 0. To increment
     * allowed value is better to use this function to avoid 2 calls (and wait until
     * the first transaction is mined)
     * From MonolithDAO Token.sol
     * @param _spender The address which will spend the funds.
     * @param _addedValue The amount of tokens to increase the allowance by.
     */
    //OK
    function increaseApproval(
    //OK
        address _spender,
    //OK
        uint _addedValue
    )
        //OK
    public
        //OK
    returns (bool)
    {
        //OK
        allowed[msg.sender][_spender] = (
        //OK
        allowed[msg.sender][_spender].add(_addedValue));
        //OK
        emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        //OK
        return true;
    }

    /**
     * @dev Decrease the amount of tokens that an owner allowed to a spender.
     *
     * approve should be called when allowed[_spender] == 0. To decrement
     * allowed value is better to use this function to avoid 2 calls (and wait until
     * the first transaction is mined)
     * From MonolithDAO Token.sol
     * @param _spender The address which will spend the funds.
     * @param _subtractedValue The amount of tokens to decrease the allowance by.
     */
    //OK
    function decreaseApproval(
    //OK
        address _spender,
    //OK
        uint _subtractedValue
    )
        //OK
    public
        //OK
    returns (bool)
    {
        //OK
        uint oldValue = allowed[msg.sender][_spender];
        //OK
        if (_subtractedValue > oldValue) {
            //OK
            allowed[msg.sender][_spender] = 0;
            //OK
        } else {
            //OK
            allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
        }
        //OK
        emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        //OK
        return true;
    }

}


//OK
contract KNT is StandardToken {
    //OK
    string public constant name = "Kora Network Token";
    //OK
    string public constant symbol = "KNT";
    //WARNING: decimals are not equal to 18
    uint32 public constant decimals = 16;
    //WARNING: invalid supply
    uint256 public INITIAL_SUPPLY = 712500000;


    //OK
    constructor() public {
        //OK
        totalSupply_ = INITIAL_SUPPLY;
        //OK
        balances[msg.sender] = INITIAL_SUPPLY;
        //OK
        emit Transfer(0x0, msg.sender, INITIAL_SUPPLY);
    }
}

