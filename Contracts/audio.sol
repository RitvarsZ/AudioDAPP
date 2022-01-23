// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Audio {
    struct Record {
        string title;
        string artist;
        string genre;
        uint year;
        uint price;
        bool is_for_sale;
        bytes32 fingerprint;
        address payable holder;
        string uri;
    }
    address private owner;
    bytes32[] public recordList;
    mapping(bytes32 => Record) records;

    event RecordUpdated(
        Record record
    );

    event RecordRegistered(
        Record record
    );

    modifier onlyIfForSale(bytes32 key) {
        require(records[key].is_for_sale, "Record is not for sale");
        _;
    }

    modifier isHolder(bytes32 key, address holder) {
        require(records[key].holder == holder, "Caller is not the holder of this record");
        _;
    }

    modifier isOwner() {
        require(msg.sender == owner, "Caller is not the owner of this contract");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /**
        Register a new record
        @param title The title of the record
        @param artist The artist of the record
        @param genre The genre of the record
        @param year The year of the record
        @param price The price of the record
        @param is_for_sale Whether the record is for sale
        @param fingerprint The fingerprint of the record
     */
    function registerRecord(
        string memory title,
        string memory artist,
        string memory genre,
        uint year,
        uint price, // price in Wei
        bool is_for_sale,
        bytes32 fingerprint,
        string memory uri // ipfs link to the record
    ) public {
        require(records[fingerprint].fingerprint != fingerprint, "Record already exists");

        Record memory record = Record(title, artist, genre, year, price, is_for_sale, fingerprint, payable(msg.sender), uri);
        records[fingerprint] = record;

        recordList.push(fingerprint);

        emit RecordRegistered(record);
    }

    /**
        Get info about a record
        @param key The fingerprint of the record to retrieve.
     */
    function getRecord(bytes32 key) public view returns (Record memory) {
        Record memory record = records[key];

        return record;
    }

    /**
        Buy a record.
        @param key The fingerprint of the record to buy.
     */
    function buyRecord(bytes32 key) payable public onlyIfForSale(key) {
        require(records[key].price == msg.value, "Invalid ammount supplied");

        Record memory record = records[key];
        record.is_for_sale = false;

        record.holder.transfer(msg.value);

        record.holder = payable(msg.sender);
        records[key] = record;

        emit RecordUpdated(record);
    }

    /**
        Make the record available for purchase.
        @param key The fingerprint of the record to be made available.
     */
    function setIsForSale(bytes32 key, bool status) public isHolder(key, msg.sender) {
        Record memory record = records[key];
        record.is_for_sale = status;
        records[key] = record;

        emit RecordUpdated(record);
    }

    function setPrice(bytes32 key, uint price) public isHolder(key, msg.sender) {
        Record memory record = records[key];
        record.price = price;
        records[key] = record;

        emit RecordUpdated(record);
    }

    /**
        Transfer ownership of a record directly to another address.
        @param key The fingerprint of the record to get.
        @param new_holder The new holder of the record.
     */
    function transferRecord(bytes32 key, address payable new_holder) public isHolder(key, msg.sender) {
        Record memory record = records[key];
        record.holder = new_holder;
        records[key] = record;

        emit RecordUpdated(record);
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}