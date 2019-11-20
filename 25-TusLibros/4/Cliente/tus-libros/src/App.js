import React from 'react';
import { Route, Switch } from 'react-router-dom'
import CreateCart from './components/create-cart';
import CatalogList from './components/catalog-list';
import CatalogItem from './components/catalog-item';
import ShoppingCart from './components/shopping-cart';
import UserPurchases from './components/user-purchases';

function App() {
  return (
    <Switch>
      <Route exact path="/" component={CreateCart} />
      <Route exact path="/catalog" component={CatalogList} />
      <Route path="/catalogItem/:itemId" component={CatalogItem} />
      <Route path="/userPurchases/" component={UserPurchases} />
      <Route path="/shoppingCart/" component={ShoppingCart} />
    </Switch>
  )
}

export default App;
