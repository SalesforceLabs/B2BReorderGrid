import {LightningElement, api} from 'lwc';

export default class OrderGridTableDateColumnHeader extends LightningElement{
    @api columnHeader;

    addAllOrderQuantities(){
        const detail = {
            orderId: this.columnHeader.orderId
        };

        const addOrderQuantitiesEvent = new CustomEvent('addorderquantitiesevent', {
            detail: detail,
            bubbles: false,
            composed: false
        });
        this.dispatchEvent(addOrderQuantitiesEvent);
    }
}