import {LightningElement, api} from 'lwc';

export default class OrderGridTableMainCell extends LightningElement{
    @api productName;
    @api productSKU;
    @api productImageURL;
}