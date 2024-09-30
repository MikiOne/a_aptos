// module my_addr::object_playground {
//     use std::signer;
//     use aptos_framework::object;
//     use aptos_framework::object::object_exists;
//     use aptos_framework::object::ObjectGroup;
//
//     /// Seed for my named object, must be globally unique to the creating account
//     const NAME: vector<u8> = b"MyAwesomeObject";
//
//     #[resource_group_member(group = ObjectGroup)]
//     struct MyStruct has key {
//         num: u8
//     }
//
//     entry fun create_my_object(caller: &signer) {
//         let caller_address = signer::address_of(caller);
//         let constructor_ref = object::create_named_object(caller, NAME);
//
//         // Retrieves a signer for the object
//         let object_signer = object::generate_signer(&constructor_ref);
//
//         // Moves the MyStruct resource into the object
//         move_to(&object_signer, MyStruct { num: 0 });
//     }
//
//     #[view]
//     fun has_object(creator: address): bool {
//         let object_address = object::create_object_address(&creator, NAME);
//         object_exists<0x1::object::ObjectCore>(object_address)
//     }
// }
module my_addr::object_playground {
    use std::signer;
    use std::string::{Self, String};
    use aptos_framework::object::{Self, Object, ObjectGroup};

    /// Caller is not the owner of the object
    const E_NOT_OWNER: u64 = 1;
    /// Caller is not the publisher of the contract
    const E_NOT_PUBLISHER: u64 = 2;

    #[resource_group_member(group = ObjectGroup)]
    struct MyStruct has key {
        num: u8
    }

    #[resource_group_member(group = ObjectGroup)]
    struct Message has key {
        message: string::String
    }

    #[resource_group_member(group = ObjectGroup)]
    struct ObjectController has key {
        extend_ref: object::ExtendRef,
    }

    entry fun create_my_object(caller: &signer) {
        let caller_address = signer::address_of(caller);

        // Creates the object
        let constructor_ref = object::create_object(caller_address);

        // Retrieves a signer for the object
        let object_signer = object::generate_signer(&constructor_ref);

        // Moves the MyStruct resource into the object
        move_to(&object_signer, MyStruct { num: 0 });

        // Creates an extend ref, and moves it to the object
        let extend_ref = object::generate_extend_ref(&constructor_ref);
        move_to(&object_signer, ObjectController { extend_ref });
        // ...
    }

    entry fun add_message(
        caller: &signer,
        object: Object<MyStruct>,
        message: String
    ) acquires ObjectController {
        let caller_address = signer::address_of(caller);
        // There are a couple ways to go about permissions

        // Allow only the owner of the object
        // assert!(object::is_owner(object, caller_address), E_NOT_OWNER);
        // Allow only the publisher of the contract
        assert!(caller_address == @my_addr, E_NOT_PUBLISHER);
        // Or any other permission scheme you can think of, the possibilities are endless!

        // Use the extend ref to get a signer
        let object_address = object::object_address(&object);
        let extend_ref = &borrow_global<ObjectController>(object_address).extend_ref;
        let object_signer = object::generate_signer_for_extending(extend_ref);

        // Extend the object to have a message
        move_to(&object_signer, Message { message });
    }
}