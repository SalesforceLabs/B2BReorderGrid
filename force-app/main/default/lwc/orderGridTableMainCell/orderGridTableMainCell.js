/*
==========================================
    Title: orderGridTableMainCell
    Purpose: Component that displays the
        product name, SKU. and image.
    Author: Clay Phillips
    Date: 08/20/2020 
==========================================
*/

import {LightningElement, api} from 'lwc';

export default class OrderGridTableMainCell extends LightningElement{
    @api productName;
    @api productSKU;
    @api productImageURL;
}