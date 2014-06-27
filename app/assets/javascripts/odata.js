/*This applies the click handlers to the buttons when the page loads.*/
$(document).ready(function(){
	$("#supplier").click(getSupplier);
	$("#orders").click(getOrders);
	$("#customers").click(getCustomers);
});

/*This function gets the product id entered 
* It then sends a asynchronous call to the server
* to get the supplier details fo the product.
* The results are displayed in the result div
*/
function getSupplier(){
	var productID = getProductId();
	
	if(productID>0){
		$.ajax({
			url: "/odata/supplier",
			data: {"productID":productID},
			type: "GET",
			accepts: "html",
			success: displayResult
		});
	}else{
		$("#result").html("<span class=\"error\">You must enter a valid product id.</span>");
	}
	
}

/*This function submits the form to 
* get the orders of the given product id.
* This is a synchronous call.
*/
function getOrders(){
	var productID = getProductId();
	if(productID>0){
		$("#prodIdForm").submit();	
	}else{
		$("#result").html("<span class=\"error\">You must enter a valid product id.</span>");
	}
}

/*This function gets the product id entered 
* It then sends a asynchronous call to the server
* to get the customers who ordered the product
* The results are displayed in the result div
*/
function getCustomers(){
	var productID = getProductId();
	if(productID>0){
		$.ajax({
			url: "/odata/customerContact",
			data: {"productID":productID},
			type: "GET",
			accepts: "html",
			success: displayResult
		});
	}else{
		$("#result").html("<span class=\"error\">You must enter a valid product id.</span>");
	}
}

/*This returns the contents of the text box productID.*/
function getProductId(){
	return $("#productID").val();
}

/*This displays the results of the asynchronous calls.*/
 function displayResult(data){	
	$("#result").html(data);
}
