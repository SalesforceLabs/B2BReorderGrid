import {LightningElement, api} from 'lwc';

export default class OrderGridTableQuantityInput extends LightningElement{
    @api quantity;
    @api productId;

    changeQuantity(event){
        if(event.target.value.length > 0){
            this.quantity = parseInt(event.target.value, 10);
        }
    }

    addQuantity(){
        if(this.quantity && this.quantity > 0){
            const detail = {
                productId: this.productId,
                quantity: this.quantity
            };

            const addProductQuantityEvent = new CustomEvent('addproductquantityevent', {
                detail: detail,
                bubbles: false,
                composed: false
            });
            this.dispatchEvent(addProductQuantityEvent);
        }
    }
}