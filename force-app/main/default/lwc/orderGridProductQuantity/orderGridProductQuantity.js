import {LightningElement, api} from 'lwc';

export default class OrderGridProductQuantity extends LightningElement{
    @api productId;

    @api
    get productQuantities(){
        return this._productQuantities;
    }

    set productQuantities(value){
        this._productQuantities = value;

        let productFound = false;
        for(let i = 0; i < this._productQuantities.length; i++){
            const productQuantity = this._productQuantities[i];

            if(productQuantity.productId === this.productId){
                this._quantity = productQuantity.quantity;
                productFound = true;
                break;
            }

        }
        if(!productFound){
            this._quantity = 0;
        }
    }

    _productQuantities;
    _quantity;

    renderedCallback() {
        const style = document.createElement('style');
        style.innerText = `c-order-grid-product-quantity .slds-input {
            text-align: center;
        }`;
        this.template.querySelector('lightning-input').appendChild(style);
    }

    changeQuantity(event){
        if(event.target.value >= 0){
            this._quantity = parseInt(event.target.value, 10);
            console.log('quantity', this._quantity);
        }
        else{
            return;
        }

        const detail = {
            productId: this.productId,
            quantity: this._quantity
        };

        const changeProductQuantityEvent = new CustomEvent('changeproductquantityevent', {
            detail: detail,
            bubbles: false,
            composed: false
        });
        this.dispatchEvent(changeProductQuantityEvent);
    }
}