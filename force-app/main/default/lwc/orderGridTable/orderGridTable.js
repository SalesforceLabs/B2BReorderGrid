import {LightningElement, api} from 'lwc';

export default class OrderGridTable extends LightningElement{
    @api orderProducts;

    @api
    get sortObject(){
        return this._sortObject;
    }

    set sortObject(value){
        this._sortObject = value;
        if(this._sortObject){
            this.sortTableRows();
        }
    }
    _sortObject;

    @api
    get orderYear(){
        return this._orderYear;
    }

    set orderYear(value){
        this._orderYear = value;
        this.filterOrderProductsByYear();
    }
    _orderYear;

    @api
    get searchText(){
        return this._searchText;
    }

    set searchText(value){
        this._searchText = value;
        if(this._searchText.length > 0){
            this.filterOrderProductsByNameSKU();
        }
        else{
            this.filterOrderProductsByYear();
        }
    }
    _searchText;

    @api
    get resetQuantities(){
        return this._resetQuantities;
    }

    set resetQuantities(value){
        this._resetQuantities = value;
        this.productQuantities = [];
        this.totalProductQuantity = 0;
        this.addToCartDisabled = true;
    }
    _resetQuantities

    filteredOrderProducts = [];
    filteredOrderProductsCopy = [];
    orderColumns = [];
    orderColumnStrings = [];
    tableRows = [];
    tableRowOne = {};
    productArray = [];
    productQuantities = [];
    totalProductQuantity = 0;

    showTable = false;
    showNoOrdersMessage = false;
    showNoMatchingProductsMessage = false;

    addToCartDisabled = true;

    filterOrderProductsByYear(){
        if(!this._orderYear){
            const today = new Date();
            this._orderYear = today.getFullYear();
        }

        this.filteredOrderProducts = [];
        this.orderProducts.forEach((op) =>{
            const orderedDateRaw = new Date(op.orderedDate);
            const orderedDate = new Date(orderedDateRaw.getTime() + orderedDateRaw.getTimezoneOffset() * 60000);
            if(orderedDate.getFullYear() === this._orderYear){
                this.filteredOrderProducts.push(op);
            }
        }) 
        
        if(this.filteredOrderProducts.length > 0){
            this.filteredOrderProductsCopy = this.filteredOrderProducts;
            this.orderColumns = [];
            this.orderColumnStrings = [];
            this.tableRows = [];
            this.productArray = [];
            this.productQuantities = [];
            this.totalProductQuantity = 0;
            this.addToCartDisabled = true;
            this.sortObject = null;
            this.createTable();
            this.showNoOrdersMessage = false;
            this.showTable = true;
        }
        else{
            this.showTable = false;
            this.showNoOrdersMessage = true;
        }

        this.sendShowTableEvent();
    }

    filterOrderProductsByNameSKU(){
        let filteredOrderProducts = [];
        this.filteredOrderProductsCopy.forEach((op) =>{
            if(op.productName.toLowerCase().includes(this._searchText.toLowerCase())
                || op.productSKU.toLowerCase().includes(this._searchText.toLowerCase())){
                
                    filteredOrderProducts.push(op);
            }
        }) 

        this.filteredOrderProducts = filteredOrderProducts;

        if(this.filteredOrderProducts.length > 0){ 
            this.orderColumns = [];
            this.orderColumnStrings = [];
            this.tableRows = [];
            this.productArray = [];
            this.productQuantities = [];
            this.totalProductQuantity = 0;
            this.addToCartDisabled = true;
            this.sortObject = null;
            this.createTable();
            this.showNoMatchingProductsMessage = false;
            this.showTable = true;
        }
        else{
            this.showTable = false;
            this.showNoMatchingProductsMessage = true;
        }
    }

    createTable(){
        this.parseOrderItems();
        this.createTableRows();
    }

    parseOrderItems(){
        this.filteredOrderProducts.forEach((op) =>{
            this.createDateColumnHeader(op);
            this.createProductArray(op);
        })
    }

    createDateColumnHeader(op){
        const orderedDateRaw = new Date(op.orderedDate);
        const orderedDate = new Date(orderedDateRaw.getTime() + orderedDateRaw.getTimezoneOffset() * 60000); //needed to account for the time offset
        
        let columnLabel = this.getMonthString(orderedDate.getMonth()) + ' ';
        columnLabel += orderedDate.getDate() + ', ' + orderedDate.getFullYear();

        const orderColumn = {
            orderId: op.orderId,
            label: columnLabel,
            date: op.orderedDate
        }

        if(this.orderColumnStrings.includes(JSON.stringify(orderColumn))){
            return;
        }

        this.orderColumnStrings.push(JSON.stringify(orderColumn));
        this.orderColumns.push(orderColumn);
    }

    createProductArray(op){
        let productImageURL = 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSwBrSo8HehhfVpXFpR4YXHM9LSpOZv-TZeogIqNbKWP2DimHiL9YI&usqp=CAc';
        if(op.productImageURL){
            productImageURL = op.productImageURL;
        }
        const productObject = {
            Id: op.productId,
            SKU: op.productSKU,
            name: op.productName,
            productImageURL: productImageURL,
            quantityValues: []
        }

        const productObjectString = JSON.stringify(productObject);

        if(this.productArray.includes(productObjectString)){
            return;
        }
        
        this.productArray.push(productObjectString);
    }

    createTableRows(){
        for(let i = 0; i < this.productArray.length; i++){
            const productObject = JSON.parse(this.productArray[i]);

            for(let b = 0; b < this.orderColumns.length; b++){
                const order = this.orderColumns[b];
                let matchFound = false;

                for(let c = 0; c < this.filteredOrderProducts.length; c++){
                    if(this.filteredOrderProducts[c].productId === productObject.Id
                        && this.filteredOrderProducts[c].orderId === order.orderId){
                            const uniqueQuantityObj = {
                                quantity: this.filteredOrderProducts[c].quantity,
                                uniqueQuantity: this.filteredOrderProducts[c].quantity + ' ' + Math.random()
                            };

                            productObject.quantityValues.push(uniqueQuantityObj);
                            matchFound = true;
                            break;
                    }
                }
                if(!matchFound){
                    const uniqueQuantityObj = {
                        quantity: 0,
                        uniqueQuantity: Math.random()
                    };

                    productObject.quantityValues.push(uniqueQuantityObj);
                }
            }
            
            this.tableRows.push(productObject);
        }
        this.tableRowOne = this.tableRows[0];
    }

    sortTableRows(){
        if(this._sortObject.sortDirection === 'ASC'){
            this.sortByFieldAscending(this._sortObject.sortField);
            return;
        }
        
        this.sortByFieldDescending(this._sortObject.sortField);
    }

    sortByFieldAscending(fieldName){
        function compare(a, b){
            const valueA = a[fieldName];
            const valueB = b[fieldName];

            let comparison = 0;
            if(valueA != null && valueB != null){
                if(valueA > valueB){
                    comparison = 1;
                }
                else if(valueA < valueB){
                    comparison = -1;
                }
            }
            else if(valueA == null && valueB != null){
                comparison = 1;
            }
            else if(valueA != null && valueB == null){
                comparison = -1;
            }
            
            return comparison;
        }
          
        this.tableRows.sort(compare);

        //Needed to refresh the UI due to the reactivity of LWCs
        this.tableRows = [...this.tableRows];
    }

    sortByFieldDescending(fieldName){
        function compare(a, b){
            const valueA = a[fieldName];
            const valueB = b[fieldName];

            let comparison = 0;
            if(valueA != null && valueB != null){
                if(valueB > valueA){
                    comparison = 1;
                }
                else if(valueB < valueA){
                    comparison = -1;
                }
            }
            else if(valueA == null && valueB != null){
                comparison = 1;
            }
            else if(valueA != null && valueB == null){
                comparison = -1;
            }
            
            return comparison;
        }
          
        this.tableRows.sort(compare);

        //Needed to refresh the UI due to the reactivity of LWCs
        this.tableRows = [...this.tableRows];
    }

    getMonthString(monthNumber){
        if(monthNumber === 0){
            return 'Jan';
        }
        else if(monthNumber === 1){
            return 'Feb';
        }
        else if(monthNumber === 2){
            return 'Mar';
        }
        else if(monthNumber === 3){
            return 'Apr';
        }
        else if(monthNumber === 4){
            return 'May';
        }
        else if(monthNumber === 5){
            return 'Jun';
        }
        else if(monthNumber === 6){
            return 'Jul';
        }
        else if(monthNumber === 7){
            return 'Aug';
        }
        else if(monthNumber === 8){
            return 'Sep';
        }
        else if(monthNumber === 9){
            return 'Oct';
        }
        else if(monthNumber === 10){
            return 'Nov';
        }
        else if(monthNumber === 11){
            return 'Dec';
        }
    }

    addProductQuantityHandler(event){
        let productFound = false;
        for(let i = 0; i < this.productQuantities.length; i++){
            const productQuantity = this.productQuantities[i];

            if(productQuantity.productId === event.detail.productId){
                productQuantity.quantity += event.detail.quantity;
                this.totalProductQuantity += event.detail.quantity;
                this.productQuantities.splice(i, 1, productQuantity);
                productFound = true;
                break;
            }
        }
        if(!productFound){
            const productQuantity = {
                productId: event.detail.productId,
                quantity: event.detail.quantity
            }
            this.productQuantities.push(productQuantity);
            this.totalProductQuantity += event.detail.quantity;
        }

        //Needed to refresh the UI due to the reactivity of LWCs
        this.productQuantities = [...this.productQuantities]; 

        this.addToCartDisabled = false;
    }

    addOrderQuantitiesHandler(event){
        for(let i = 0; i < this.filteredOrderProducts.length; i++){
            const orderProduct = this.filteredOrderProducts[i];
            if(orderProduct.orderId === event.detail.orderId){
                let productFound = false;
                for(let a = 0; a < this.productQuantities.length; a++){
                    const productQuantity = this.productQuantities[a];

                    if(orderProduct.productId === productQuantity.productId){
                        productQuantity.quantity += orderProduct.quantity;
                        this.totalProductQuantity += orderProduct.quantity;
                        this.productQuantities.splice(a, 1, productQuantity);
                        productFound = true;
                        break;
                    }
                }
                if(!productFound){
                    const productQuantity = {
                        productId: orderProduct.productId,
                        quantity: orderProduct.quantity
                    }
                    this.productQuantities.push(productQuantity);
                    this.totalProductQuantity += orderProduct.quantity;
                }
            }
        }

        //Needed to refresh the UI due to the reactivity of LWCs
        this.productQuantities = [...this.productQuantities];

        this.addToCartDisabled = false;
    }

    changeProductQuantityHandler(event){
        let productFound = false;
        for(let i = 0; i < this.productQuantities.length; i++){
            const productQuantity = this.productQuantities[i];

            if(productQuantity.productId === event.detail.productId){
                if(event.detail.quantity){
                    productQuantity.quantity = event.detail.quantity;
                }
                else{
                    productQuantity.quantity = 0;
                }
                this.productQuantities.splice(i, 1, productQuantity);
                productFound = true;
                break;
            }
        }
        if(!productFound){
            let quantity = 0;
            if(event.detail.quantity){
                quantity = event.detail.quantity;
            }
           
            const productQuantity = {
                productId: event.detail.productId,
                quantity: quantity
            }
            this.productQuantities.push(productQuantity);
        }

        let totalProductQuantity = 0;
        this.productQuantities.forEach((pq) =>{
            totalProductQuantity += pq.quantity;
        }) 

        this.totalProductQuantity = totalProductQuantity;
        if(this.totalProductQuantity > 0){
            this.addToCartDisabled = false;
        }
        else{ 
            this.addToCartDisabled = true;  
        }
    }

    sendShowTableEvent(){
        const detail = {
            showTable: this.showTable
        };

        const showTableEvent = new CustomEvent('showtableevent', {
            detail: detail,
            bubbles: false,
            composed: false
        });
        this.dispatchEvent(showTableEvent);
    }

    addToCart(){
        const detail = {
            cartProducts: this.productQuantities
        };

        const addToCartEvent = new CustomEvent('addtocartevent', {
            detail: detail,
            bubbles: false,
            composed: false
        });
        this.dispatchEvent(addToCartEvent);
    }
}