import React from 'react';
import { Link } from 'react-router-dom'

function CreateCart() {

    return (
        <div>
            <div>Create Cart </div>
            <div>
                <Link to="/catalog">Catalog</Link>
            </div>
            <div>
                <Link to="/catalogItem/test">Catalog Item with id test</Link>
            </div>
            <div>
                <Link to="/userPurchases">User Purchases</Link>
            </div>
            <div>
                <Link to="/shoppingCart">Shopping Cart</Link>
            </div>
        </div>
    );
};

export default CreateCart;