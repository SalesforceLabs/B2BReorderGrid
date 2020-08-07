import {LightningElement, wire, api} from 'lwc';
import commId from '@salesforce/community/Id';
import getOrderProducts from '@salesforce/apex/orderGridController.getOrderProducts';
import addToCart from '@salesforce/apex/orderGridController.addToCart';

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
        if(data){
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
        addToCart({
            productsJSON: JSON.stringify(event.detail.cartProducts),
            communityId: this.communityId,
            effectiveAccountId: this.resolvedEffectiveAccountId
        })
        .then((result) => {
            console.log('result', result);
        })
        .catch((error) => {
            console.log('Error received: ' + error.errorCode);
        });
    }
}