import {LightningElement, wire, api} from 'lwc';
import commId from '@salesforce/community/Id';
import getOrderProducts from '@salesforce/apex/orderGridController.getOrderProducts';
import addToCart from '@salesforce/apex/orderGridController.addToCart';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class OrderGridMain extends LightningElement{
    @api
    effectiveAccountId;

    get resolvedEffectiveAccountId(){
        const effectiveAccountId = this.effectiveAccountId || "";
        let resolved = null;

        if(effectiveAccountId.length > 0 && effectiveAccountId !== "000000000000000"){
            resolved = effectiveAccountId;
        }

        return resolved;
    }

    communityId = null;

    connectedCallback(){
        this.communityId = commId;
    }

    orderProducts = null;
    sortObject;
    orderYear;
    showTable;
    searchText = '';
    resetQuantities;

    orderProductWrapperString = '';
    imageURL = '';

    @wire(getOrderProducts, {
        communityId: "$communityId",
        effectiveAccountId: "$resolvedEffectiveAccountId"
    })
    getOrderProductsTwo({error, data}){
        console.log('effectiveAccountId', this.resolvedEffectiveAccountId);
        
        if(data && data.length){
            this.orderProducts = data;
        }
        else if(error){
            console.log('Error received: ' + JSON.stringify(error));
        }
    }

    selectYearEventHandler(event){
        this.orderYear = event.detail.orderYear;
    }

    searchEventHandler(event){
        this.searchText = event.detail.searchText;
        console.log('orderGridMain Search Text', this.searchText);
    }

    sortEventHandler(event){
        this.sortObject = event.detail;
    }

    resetQuantitiesEventHandler(event){
        this.resetQuantities = event.detail.randomNumber;
    }

    showTableEventHandler(event){
        this.showTable = event.detail.showTable;
    }

    addToCartEventHandler(event){
        //console.log('communityId', this.communityId, 'effectiveAccountId', this.resolvedEffectiveAccountId);
        const cartProducts = event.detail.cartProducts;
        let totalQuantity = 0;

        cartProducts.forEach((cartProduct) =>{
            totalQuantity += cartProduct.quantity;
        })

        addToCart({
            productsJSON: JSON.stringify(event.detail.cartProducts),
            communityId: this.communityId,
            effectiveAccountId: this.resolvedEffectiveAccountId
        })
        .then((result) => {
            console.log('result', result);

            if(result){
                let title = '';
                if(totalQuantity > 1){
                    title = 'Items Added to Cart';
                }
                else{
                    title = 'Item Added to Cart';
                }

                let message = 'You have successfully added ' + totalQuantity;
                if(totalQuantity > 1){
                    message += ' products to your cart.';
                }
                else{
                    message += ' product to your cart.';
                }

                this.resetQuantities = Math.random();
                this.showToast(title, message, 'success', 'dismissable');
            }
            else{
                this.showToast('Error When Adding to Cart',
                    'An error occurred when adding products to your cart. Please contact an administrator for assistance.',
                    'error',
                    'sticky');
            }
        })
        .catch((error) => {
            console.log('Error received: ' + error.errorCode);
        });
    }

    showToast(title, message, variant, mode) {
        const event = new ShowToastEvent({
            title,
            message,
            variant,
            mode
        });

        this.dispatchEvent(event);
    }
}