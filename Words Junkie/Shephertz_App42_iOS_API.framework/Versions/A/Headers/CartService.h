//
//  CartService.h
//  PAE_iOS_SDK
//
//  Created by Shephertz Technology on 13/04/12.
//  Copyright (c) 2012 ShephertzTechnology PVT LTD. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CartResponseBuilder.h"
#import "Cart.h"
#import "App42Response.h"
#import "App42Service.h"
/**
 * This is Cloud Persistent Shopping Cart Service. App Developers can use this
 * to create a Shopping Cart. Add Items and Check Out items. It also maintains
 * the transactions and the corresponding Payment Status. The Payment Gateway
 * interface is not provided by the Platform. It is left to the App developer
 * how he wants to do the Payment Integration. This can be used along with
 * Catalogue or used independently
 *
 * @see Catalgoue
 * @see Cart
 * @see App42Response
 * @see ItemData
 * @see PaymentStatus
 *
 */

/**
 * Transaction Status
 */
extern NSString *const DECLINED;
/**
 * Transaction Status
 */
extern NSString *const AUTHORIZED;
/**
 * Transaction Status
 */
extern NSString *const PENDING;



@interface CartService : App42Service
{
    
    
}

-(id)init __attribute__((unavailable));
-(id)initWithAPIKey:(NSString *)apiKey  secretKey:(NSString *)secretKey;

/**
 * Creates a Cart Session for the specified User
 *
 * @param user
 *            - User for whom Cart Session has to be created
 *
 * @returns Cart Object containing Cart Id with Creation Time. The id has to
 *          be used in subsequent calls for adding and checking out
 *
 */
-(Cart*)createCart:(NSString*)user;
/**
 * Fetch Cart details. Can be used by the App developer to display Cart
 * Details i.e. Items in a Cart.
 *
 * @param cartId
 *            - The Cart Id that has to be fetched
 *
 * @returns Cart object containing cart details with all the items which are
 *          in it. It also tells the state of the Cart
 *
 */
-(Cart*)getCartDetails:(NSString*)cartId;
/**
 * Adds an Item in the Cart with quantity and price. This method does not
 * take currency. Its the bonus of the App developer to maitain the
 * currency. It takes only the price.
 *
 * @param cartID
 *            - The Cart Id into which item has to be added
 * @param itemID
 *            - The Item id which has to be added in the cart. If the
 *            Catalogue Service is used along with the Cart Service then the
 *            Item ids should be same.
 * @param itemQuantity
 *            - Quantity of the Item to be purchased
 * @param price
 *            - Price of the item
 *
 * @returns Cart object containing added item.
 *
 */
-(Cart*)addItem:(NSString*)cartID itemID:(NSString*)itemID itemQuantity:(int)itemQuantity price:(double)price;
/**
 * Fetches the Items from the specified Cart
 *
 * @param cartId
 *            - The cart id from which items have to be fetched
 *
 * @returns Cart object which contains all items in the cart
 *
 */
-(Cart*)getItems:(NSString*)cartId;

/**
 * Fetches the specified Item from the specified Cart
 *
 * @param cartId
 *            - The cart id from which item has to be fetched
 * @param itemId
 *            - The item for which the information has to be fetched
 *
 * @returns Cart Object
 *
 */
-(Cart*)getItem:(NSString*)cartId itemId:(NSString*)itemId;
/**
 * Removes the specified item from the specified Cart
 *
 * @param cartId
 *            - The cart id from which the item has to be removed
 * @param itemId
 *            - Id of the Item which has to be removed
 *
 * @returns App42Response if removed successfully
 *
 */
-(App42Response*)removeItem:(NSString*)cartId itemId:(NSString*)itemId;
/**
 * Removes all Items from the specified Cart
 *
 * @param cartId
 *            - The cart id from which items have to be removed
 *
 * @returns App42Response if removed successfully
 *
 */
-(App42Response*)removeAllItems:(NSString*)cartId;
/**
 * Checks whether the Cart is Empty or not
 *
 * @param cartId
 *            - The cart id to check for empty
 *
 * @returns Cart object (isEmpty method on Cart object can be used to check
 *          status)
 *
 */
-(Cart*)isEmpty:(NSString*)cartId;
/**
 * Checks out the Cart and put it in CheckOut Stage and returns the
 * Transaction Id The transaction id has to be used in future to update the
 * Payment Status.
 *
 * @param cartID
 *            - The cart id that has to be checkedOut.
 *
 * @returns Cart object containing Checked Out Cart Information with the
 *          Transaction Id
 *
 */
-(Cart*)checkOut:(NSString*)cartID;
/**
 * Update Payment Status of the Cart. When a Cart is checkout, it is in
 * Checkout state. The payment status has to be updated based on the Payment
 * Gateway interaction
 *
 * @param cartID
 *            - The cart id for which the payment status has to be updated
 * @param transactionID
 *            - Transaction id for which the payment status has to be
 *            updated
 * @param paymentStatus
 *            - Payment Status to be updated. The probable values are
 *            PaymentStatus.DECLINED, PaymentStatus.AUTHORIZED,
 *            PaymentStatus.PENDING
 *
 * @returns Cart object which contains Payment Status
 *
 */
-(Cart*)payment:(NSString*)cartID transactionID:(NSString*)transactionID paymentStatus:(NSString*)paymentStatus;

/**
 * Fetches Payment information for a User. This can be used to display Order
 * and Payment History
 *
 * @param userId
 *            - User Id for whom payment information has to be fetched
 *
 * @returns List containing Cart objects. Payment history can be retrieved
 *          from individual Cart object.
 *
 */
-(NSArray*)getPaymentsByUser:(NSString*)userId;

/**
 * Fetches Payment information for the specified Cart Id
 *
 * @param cartID
 *            - Cart Id for which the payment information has to be fetched
 *
 * @returns Cart object which contains Payment History for the specified
 *          Cart
 *
 */
-(Cart*)getPaymentByCart:(NSString*)cartID;

/**
 * Fetches Payment information based on User Id and Status
 *
 * @param userId
 *            - User Id for whom payment information has to be fetched
 *@param paymentStatus
 *            - Status of type which payment information has to be fetched
 *
 * @returns List containing Cart objects. Payment history can be retrieved
 *          from individual Cart object.
 *
 * @returns Payment History
 *
 */
-(NSArray*)getPaymentsByUserAndStatus:(NSString*)userId status:(NSString*)paymentStatus;
/**
 *
 * Fetches Payment information based on Status
 *
 * @param paymentStatus
 *            - Status of type which payment information has to be fetched
 *
 * @returns List containing Cart objects. Payment history can be retrieved
 *          from individual Cart object.
 *
 */
-(NSArray*)getPaymentsByStatus:(NSString*)paymentStatus;


/**
 * History of Carts and Payments for a User. It gives all the carts which
 * are in AUTHORIZED, DECLINED, PENDING state.
 *
 * @param userId
 *            - User Id for whom payment history has to be fetched
 *
 * @returns List containing Cart objects. Payment history can be retrieved
 *          from individual Cart object.
 *
 */
-(NSArray*)getPaymentHistoryByUser:(NSString*)userId;
/**
 * History of all carts. It gives all the carts which are in AUTHORIZED,
 * DECLINED, PENDING state.
 *
 * @returns List containing Cart objects. Payment history can be retrieved
 *          from individual Cart object.
 *
 */
-(NSArray*)getPaymentHistoryAll;
/**
 * To increase quantity of existing item in the cart.
 *
 * @param cartID
 *            - The Cart Id into which item has to be added
 * @param itemID
 *            - The Item id which has to be added in the cart. If the
 *            Catalogue Service is used along with the Cart Service then the
 *            Item ids should be same.
 * @param itemQuantity
 *            - Quantity of the Item to be purchased
 *
 * @returns Cart object containing updated item.
 *
 */
-(Cart*)increaseQuantity:(NSString*)cartID itemID:(NSString*)itemID itemQuantity:(int)itemQuantity;
/**
 * To decrease quantity of existing item in the cart..
 *
 * @param cartID
 *            - The Cart Id from where item quantity has to be reduced
 * @param itemID
 *            - The Item id from where item quantity has to be reduced. If
 *            the Catalogue Service is used along with the Cart Service then
 *            the Item ids should be same.
 * @param itemQuantity
 *            - Quantity of the Item has to be reduced
 *
 * @returns Cart object containing updated item.
 *
 */
-(Cart*)decreaseQuantity:(NSString*)cartID itemID:(NSString*)itemID itemQuantity:(int)itemQuantity;

@end
